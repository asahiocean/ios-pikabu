import UIKit

final class FeedModel {
    
    weak var feedView: UITableView?
    weak var storage: StorageModel?        
    
    internal init(_ feedView: UITableView, _ storage: StorageModel) {
        self.feedView = feedView
        self.storage = storage
    }
    
    final func fetch() {
        let queue = Dispatcher.queues.self
        let group = Dispatcher.groups.self
        
        group.request.enter()
        queue.request.async(group: group.request, execute: {
            API.get(to: URLS.feed, with: {
                do {
                    guard let data = try $0.get() else { return }
                    Handler.shared.worker(data) { [weak self] (result: Result<[FeedPost]?,Error>) in
                        do {
                            let feed = try result.get()
                            self?.storage?.setFeed(feed!)
                            self?.storage?.notify(group.request)
                        } catch let error as NSError {
                            fatalError(error.localizedDescription)
                        }
                    }
                } catch let error as NSError {
                    fatalError(error.localizedDescription)
                }
            })
        })
        group.request.notify(queue: .main, execute: { [weak self] in
            self?.feedView?.reloadData()
            if let ids = self?.storage?.feed.compactMap({$0.id}) {
                API.post(with: ["Post IDs" : ids])
            }
        })
    }
}

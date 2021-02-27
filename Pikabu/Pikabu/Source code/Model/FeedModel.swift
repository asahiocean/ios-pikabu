import UIKit

final class FeedModel {
    
    private var observer: NSKeyValueObservation?
    
    private weak var feedView: UITableView?
    let storage: FeedType
    
    init(_ feedView: UITableView, _ storage: FeedType) {
        self.feedView = feedView
        self.storage = storage
    }
    
    func updater() {
        func label(text string: String) -> UILabel {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = string
            label.sizeToFit()
            return label
        }
        func reload(bg view: UIView?) {
            DispatchQueue.main.async { [weak feedView] in
                feedView?.backgroundView = view
                feedView?.reloadData()
            }
        }
        switch storage {
        case .posts:
            API.get(to: URLS.feed, with: { [unowned self] in
                do {
                    guard let data = try $0.get() else { fatalError("data nil") }
                    Handler.shared.worker(data) { [storage] (result: Result<[FeedPost]?,Error>) in
                        do {
                            guard let feed = try result.get() else { fatalError("feed nil") }
                            defer { storage.config.setup(posts: feed) }
                            let store = Storage.shared
                            feed.filter({ store.likedList.contains($0.id) }).forEach({ store.liked.add(post: $0) })
                            feed.filter({ store.favList.contains($0.id) }).forEach({ store.favorites.add(post: $0) })
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
            
            let indicator = UIActivityIndicatorView(style: .large); indicator.startAnimating()
            observer = storage.config.observe(\.feed, options: [.initial,.new]) { obj, change in
                reload(bg: obj.feed.isEmpty ? indicator : nil)
            }
        case .liked:
            observer = storage.config.observe(\.feed, options: [.initial,.new]) { obj, change in
                change.newValue != nil ?> reload(bg: obj.feed.isEmpty ? label(text: "No liked posts yet.") : nil)
            }
        case .favorites:
            observer = storage.config.observe(\.feed, options: [.initial,.new]) { obj, change in
                change.newValue != nil ?> reload(bg: obj.feed.isEmpty ? label(text: "Favorites are empty.") : nil)
            }
        }
    }
}

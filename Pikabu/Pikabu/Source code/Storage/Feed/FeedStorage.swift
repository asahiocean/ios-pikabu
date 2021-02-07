import Foundation

protocol FeedStorage: class {
    var feed: [FeedPost]? { get }
    func setting(_ posts: [FeedPost])
    func getting() -> [FeedPost]?
}

extension FeedStorage {
    func notify() {
        Dispatcher.groups.request.leave()
    }
}

import Foundation

final class LocalStorage: FeedStorage {
    
    static public let shared = LocalStorage()
    
    fileprivate(set) var feed: [FeedPost]?
    
    func getting() -> [FeedPost]? {
        guard let posts = self.feed else { return nil }
        API.post(with: ["Post IDs": posts.map({$0.id})])
        return posts
    }
    
    func setting(_ posts: [FeedPost]) {
        self.feed = posts
        self.notify()
    }
}

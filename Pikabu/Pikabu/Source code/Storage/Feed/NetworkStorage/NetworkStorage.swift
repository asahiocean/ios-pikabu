import Foundation

final class NetworkStorage: FeedStorage {
    
    static public let shared = NetworkStorage()
    
    fileprivate(set) var feed: [FeedPost]?
    
    func getting() -> [FeedPost]? {
        guard let posts = feed else { return nil }
        return posts
    }
    
    func setting(_ posts: [FeedPost]) {
        feed = posts
        notify()
    }
    
    fileprivate init() {
        feed = .init()
    }
}

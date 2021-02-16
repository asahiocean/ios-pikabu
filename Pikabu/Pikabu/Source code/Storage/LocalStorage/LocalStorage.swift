import Foundation

//MARK: - Local Storage -

class LocalStorage: StorageModel {
    
    public static let shared = LocalStorage()
    
    internal var feed: [FeedPost] = []
    
    func setFeed(_ feedPosts: [FeedPost]) {
        self.feed = feedPosts
    }
    
    func getPost(_ indexPath: IndexPath) -> FeedPost? {
        return feed[indexPath.row]
    }
    
    fileprivate init() { }
}

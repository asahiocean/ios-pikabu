import Foundation

//MARK: - Network Storage -

class NetworkStorage: StorageModel {
    
    public static let shared = NetworkStorage()
    
    internal var feed: [FeedPost] = []
    
    func setFeed(_ feedPosts: [FeedPost]) {
        self.feed = feedPosts
    }
    
    func getPost(_ indexPath: IndexPath) -> FeedPost? {
        return feed[indexPath.row]
    }
    
    fileprivate init() { }
}

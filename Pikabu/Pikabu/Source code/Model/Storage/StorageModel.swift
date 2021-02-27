import Foundation

@objc class StorageModel: NSObject, StorageManager {
    
    @objc dynamic private(set) internal var feed: [FeedPost] = []
    
    func setup(posts: [FeedPost]) {
        self.feed = posts
    }
    
    func receive(post index: IndexPath) -> FeedPost? {
        feed[index.item]
    }
    
    func add(post: FeedPost) {
        feed.append(post)
    }
    
    func remove(post: FeedPost) {
        feed = feed.filter { $0 != post }
    }
}

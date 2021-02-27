import Foundation

protocol StorageManager {
    dynamic var feed: [FeedPost] { get }
    func setup(posts: [FeedPost])
    func add(post: FeedPost)
    func receive(post index: IndexPath) -> FeedPost?
    func remove(post: FeedPost)
}

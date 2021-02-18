import Foundation

//MARK: - Storage Model -

protocol StorageModel: class {
    var feed: [FeedPost] { get }
    func setFeed(_ feedPosts: [FeedPost])
    func getPost(_ indexPath: IndexPath) -> FeedPost?
}

extension StorageModel {
    // to notify about the completion of the task
    func notify(_ group: DispatchGroup) { group.leave() }
}

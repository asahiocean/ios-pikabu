import Foundation

public enum FeedType {
    
    case posts, liked, favorites
    
    var config: StorageModel {
        switch self {
        case .posts: return Storage.shared.posts
        case .liked: return Storage.shared.liked
        case .favorites: return Storage.shared.favorites
        }
    }
}

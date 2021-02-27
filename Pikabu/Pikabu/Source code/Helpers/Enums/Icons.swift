import Foundation
import UIKit.UIImage

public enum Icons {
    
    private static let regular = UIImage.SymbolConfiguration(weight:.regular)
    
    //MARK: - Liked -
    enum liked {
        static let enable = UIImage(systemName: "heart.fill", withConfiguration: regular)?.withTintColor(.systemRed)
        static let disable = UIImage(systemName: "heart", withConfiguration: enable?.configuration)
    }
    static func isLiked(of state: Bool) -> UIImage? { state ? Icons.liked.enable : Icons.liked.disable }
    
    //MARK: - Favorite -
    
    enum favorite {
        static let enable = UIImage(systemName: "star.fill", withConfiguration: regular)?.withTintColor(.systemOrange)
        static let disable = UIImage(systemName: "star", withConfiguration: enable?.configuration)
    }
    static func isFavorite(of state: Bool) -> UIImage? { state ? Icons.favorite.enable : Icons.favorite.disable }
}

import UIKit

enum Icons {
    enum heart {
        static let enable = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        static let disable = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    }
    enum star {
        static let enable = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        static let disable = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
    }
}

import UIKit.UIColor
/// Top Bar Colors
enum TBColors {
    static let bg = UIColor.systemGreen
    static let text = UIColor.white
    
    enum isSelected {
        case `true`
        case `false`
        var text: UIColor {
            switch self {
            case .`true`:
                return TBColors.text
            case .`false`:
                return TBColors.text.withAlphaComponent(0.7)
            }
        }
        var bg: UIColor {
            switch self {
            case .`true`:
                return TBColors.bg
            case .`false`:
                return TBColors.bg.withAlphaComponent(0.7)
            }
        }
    }
    
    enum isHighlighted {
        case `true`
        case `false`
        var text: UIColor {
            switch self {
            case .`true`:
                return TBColors.isSelected.true.text
            case .`false`:
                return TBColors.isSelected.false.text
            }
        }
        var bg: UIColor {
            switch self {
            case .`true`:
                return TBColors.isSelected.true.bg
            case .`false`:
                return TBColors.isSelected.false.bg
            }
        }
    }
}

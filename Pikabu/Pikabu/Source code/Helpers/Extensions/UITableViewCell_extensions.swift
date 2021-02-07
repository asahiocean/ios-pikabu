import Foundation
import UIKit.UITableViewCell

extension UITableViewCell {
    static var reuseId: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: reuseId, bundle: nil) }
}

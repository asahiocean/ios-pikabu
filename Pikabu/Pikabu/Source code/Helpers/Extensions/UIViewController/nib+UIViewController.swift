import UIKit

extension UIViewController {
    static var id: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: id, bundle: nil )}
    static var global: Self { nib.instantiate(withOwner: nil)[0] as! Self }
}

import UIKit

//MARK: - Controllers -

extension UIViewController {
    static var id: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: id, bundle: nil )}
}

//MARK: - UIViews -

extension UIView {
    static var id: String { String(describing: self )}
    static var nib: UINib? { UINib(nibName: id, bundle: nil )}
}

extension UITableViewCell {
    static var reuseId: String { String(describing: self )}
}

extension UICollectionViewCell {
    static var reuseId: String { String(describing: self )}
}

//MARK: - UINib -

extension UINib {
    func view<T>() -> T? {
        return self.instantiate(withOwner: nil, options: nil).first as? T
    }
}

import UIKit

protocol HeaderViewModel: UIView {
    var photo: UIImageView! { get }
    var usernameLabel: UILabel! { get }
    var dateLabel: UILabel! { get }
    func photo(_ image: UIImage?)
    func date(_ string: String?)
}

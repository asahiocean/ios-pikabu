import UIKit

protocol FeedPostCellModel: FooterDelegate {
    var label: UILabel! { get }
    var headerView: HeaderView! { get }
    var post: FeedPost! { get }
    var stackView: PostStackView! { get }
    var footerView: FooterView! { get }
    func content(from post: FeedPost)
}

import UIKit

protocol FeedPostCellModel {
    var label: UILabel! { get }
    var headerView: HeaderView! { get }
    var postInfo: FeedPost! { get }
    var stackView: PostStackView! { get }
    var footerView: FooterView! { get }
    func content(from post: FeedPost)
}

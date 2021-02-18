import UIKit

protocol FooterViewModel: UIView {
    var likeButton: UIButton! { get }
    func likeButtonAction(_ sender: UIButton)
    
    var favoriteButton: UIButton! { get }
    func favoriteButtonAction(_ sender: UIButton)
    
    var commentsStackView: UIStackView! { get }
    var commentsButton: UIButton! { get }
    var commentsCounter: UILabel! { get }
}

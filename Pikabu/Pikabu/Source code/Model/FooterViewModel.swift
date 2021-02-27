import UIKit

protocol FooterDelegate: class {
    func liked(state: Bool)
    func favorites(state: Bool)
}

protocol FooterViewModel: UIView {
    var likeButton: UIButton! { get }
    func likeButtonAction(_ sender: UIButton)
    
    var favoriteButton: UIButton! { get }
    func favoriteButtonAction(_ sender: UIButton)
    
    var commentsStackView: UIStackView! { get }
    var commentsButton: UIButton! { get }
    var commentsCounter: UILabel! { get }
    
    var delegate: FooterDelegate? { get set }
}

import UIKit

class FooterView: UIView, FooterViewModel {
    
    // MARK: - IBOutlets
    
    //MARK: Like button
    @IBOutlet weak var likeButton: UIButton!
    
    //MARK: Comments
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentsCounter: UILabel!
    @IBOutlet weak var commentsStackView: UIStackView!
    
    //MARK: Favorite
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Footer Delegate
    weak var delegate: FooterDelegate?
    
    // MARK: - IBAction -
    
    //MARK: Like button
    @IBAction internal func likeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let state = sender.isSelected
        DispatchQueue.main.async { [weak delegate] () -> Void in
            sender.setImage(Icons.isLiked(of: state), for: .normal)
            delegate?.liked(state: state)
        }
    }
    
    //MARK: Favorite
    @IBAction internal func favoriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let state = sender.isSelected
        DispatchQueue.main.async { [weak delegate] () -> Void in
            sender.setImage(Icons.isFavorite(of: state), for: .normal)
            delegate?.favorites(state: state)
        }
    }
}

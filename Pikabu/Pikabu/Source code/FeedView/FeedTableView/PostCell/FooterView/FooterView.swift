import UIKit

class FooterView: UIView, FooterViewModel {
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentsCounter: UILabel!
    @IBOutlet weak var commentsStackView: UIStackView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(Icons.star.enable, for: .normal)
        } else {
            sender.setImage(Icons.star.disable, for: .normal)
        }
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(Icons.star.enable, for: .normal)
        } else {
            sender.setImage(Icons.star.disable, for: .normal)
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layer.cornerRadius = 10
    }
}

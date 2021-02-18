import UIKit

class HeaderView: UIView, HeaderViewModel {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func date(_ string: String?) {
        guard (string != nil) else {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            dateLabel?.text = formatter.string(from: date)
            dateLabel?.sizeToFit()
            return
        }
    }
    
    func photo(_ image: UIImage?) {
        photo?.layer.cornerRadius = photo.bounds.size.width / 2
        photo?.image = image
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layer.cornerRadius = 10
    }
}

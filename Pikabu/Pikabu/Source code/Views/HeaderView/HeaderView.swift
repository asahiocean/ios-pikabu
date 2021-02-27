import UIKit

class HeaderView: UIView, HeaderViewModel {
    
    //MARK: - IBOutlets -
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - Config -
    
    func date(_ string: String?) {
        guard (string != nil) else {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            dateLabel.text = formatter.string(from: date)
            dateLabel.sizeToFit()
            return
        }
    }
    
    func photo(image: UIImage?) {
        photo.layer.borderColor = UIColor.systemGray4.cgColor
        photo.layer.borderWidth = 1
        photo.layer.cornerRadius = photo.bounds.size.width / 2
        photo.image = image
    }
    
    //MARK: - Init -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layer.cornerRadius = 10
    }
}

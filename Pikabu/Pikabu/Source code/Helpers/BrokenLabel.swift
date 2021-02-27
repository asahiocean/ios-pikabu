import UIKit

class BrokenLabel: UILabel {
    
    static let shared = BrokenLabel()
    
    override var text: String? {
        didSet {
            self.sizeToFit()
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 2
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        font = .boldSystemFont(ofSize: 18)
        text = "Упс, эта картинка сломалась :(" + "\n" + "Мы скоро это починим!"
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.6525524215)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

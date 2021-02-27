import UIKit

class PostTextView: UITextView {
    
    override var text: String! { didSet { sizeToFit() } }
    
    fileprivate func extractedFunc() {
        backgroundColor = .clear
        
        isUserInteractionEnabled = false
        isScrollEnabled = false
        isEditable = false
        
        let fontSize = bounds.width.squareRoot()
        font = .systemFont(ofSize: fontSize)
        contentMode = .scaleAspectFit
        textAlignment = .left
        
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.lineFragmentPadding = 0
        textContainerInset = .zero
        contentInset = .zero
    }
    
    convenience init(_ size: CGSize, _ text: String) {
        self.init(frame: CGRect(origin: .zero, size: size))
        self.text = text
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        extractedFunc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        extractedFunc()
    }
}

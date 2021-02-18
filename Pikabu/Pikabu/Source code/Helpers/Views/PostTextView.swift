import UIKit

final class PostTextView: UITextView {
    
    convenience init(_ width: CGFloat, _ text: String) {
        self.init(frame: .init(origin: .zero, size: CGSize(width: width, height: UIView.noIntrinsicMetric)))
        self.text = text
    }
    
    override var text: String! {
        didSet {
            self.sizeToFit()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainer?.lineBreakMode = .byWordWrapping
        textContainer?.lineFragmentPadding = 0
        
        font = .systemFont(ofSize: 18)
        textAlignment = .left
        
        isScrollEnabled = false
        isEditable = false
        
        textContainerInset = .zero
        contentInset = .zero
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

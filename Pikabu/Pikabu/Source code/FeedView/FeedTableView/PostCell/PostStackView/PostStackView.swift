import UIKit

class PostStackView: UIStackView {
    
    private func heightConstraint(_ c: CGFloat) {
        self.constraints.forEach({
            if $0.identifier == "height" {
//                self.setNeedsLayout()
                // self.setNeedsUpdateConstraints()
                // self.updateConstraintsIfNeeded()
                $0.constant = c > 0 ? ($0.constant + c) : 0
                // self.updateConstraints()
                self.layoutIfNeeded()
            }
        })
    }
    
    func clear() {
        self.arrangedSubviews.forEach({
            self.heightConstraint(0)
            $0.removeFromSuperview()
        })
    }
    
    override func addArrangedSubview(_ view: UIView) {
        self.heightConstraint(view.frame.height)
        super.addArrangedSubview(view)
        // self.setCustomSpacing(100, after: view as? UITextView ?? view)
    }
    
    fileprivate func setup() {
        self.isUserInteractionEnabled = false
        // self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fillProportionally
        self.alignment = .fill
        self.axis = .vertical
        self.spacing = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
}

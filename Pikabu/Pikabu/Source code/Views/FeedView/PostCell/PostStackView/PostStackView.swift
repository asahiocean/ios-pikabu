import UIKit

class PostStackView: UIStackView {
    
    func append(_ view: UIView) {
        setNeedsLayout()
        view.constraintHeightWidth()
        setHeightConstraint(equal: view.bounds.height)
        addArrangedSubview(view)
        layoutIfNeeded()
    }
    
    fileprivate func setup() {
        distribution = .fill // or .fillProportionally
        alignment = .fill
        axis = .vertical
        spacing = UIStackView.spacingUseSystem
        
        isUserInteractionEnabled = false
        
        // translatesAutoresizingMaskIntoConstraints = false
        isLayoutMarginsRelativeArrangement = false
        isBaselineRelativeArrangement = true
        directionalLayoutMargins = .zero
        layoutMargins = .zero
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

extension PostStackView {
    @objc private final func setHeightConstraint(equal value: CGFloat) {
        self.constraints.forEach({ // (value) in
            guard $0.identifier == "height" else { return }
            let height: CGFloat = $0.constant + value
            $0.constant = value > 0 ? height : 0
            frame.size.height = $0.constant
            $0.priority = .required
            $0.isActive = true
            setNeedsLayout()
        })
    }
    
    @objc open func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach({
            NSLayoutConstraint.deactivate($0.constraints)
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
        setHeightConstraint(equal: 0)
    }
}

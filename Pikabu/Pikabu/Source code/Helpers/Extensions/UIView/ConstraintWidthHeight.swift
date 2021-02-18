import UIKit

public extension UIView {
    func constraintHeightWidth() {
        let size = layer.bounds.standardized.size
        let ratio = size.height / size.width
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .width,
                                            multiplier: ratio,
                                            constant: .zero)
        constraint.shouldBeArchived = true
        constraint.identifier = "heightEqualWidth"
        constraint.priority = .required
        constraint.isActive = true
        self.addConstraint(constraint)
    }
}

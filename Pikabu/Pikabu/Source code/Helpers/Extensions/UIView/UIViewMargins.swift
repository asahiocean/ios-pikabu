import UIKit

public extension UIView {
    enum Anchor {
        case center
        case vertical
        case horizontal
        case all
    }
    
    /// This function forces constraints within the specified view
    /// - Parameters:
    ///   - view: Specify the view relative to which you want to install the constraints
    ///   - anchor: Choose a possible anchor
    ///   - padding: Specify the required indentation of anchor
    func constraints(in view: UIView, _ anchor: Anchor, p padding: CGFloat = 0) {
        self.setNeedsLayout()
        self.translatesAutoresizingMaskIntoConstraints = false
        var first: NSLayoutConstraint! { didSet { first.isActive = true }}
        var second: NSLayoutConstraint! { didSet { second.isActive = true }}
        switch anchor {
        case .center:
            first = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding)
            first.priority = .required
            second = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: padding)
            second.priority = .required
        case .vertical:
            first = topAnchor.constraint(equalTo: view.topAnchor, constant: padding)
            first.priority = .required
            second = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding)
            second.priority = .required
        case .horizontal:
            first = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
            first.priority = .required
            second = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding)
            second.priority = .required
        case .all:
            constraints(in: view, .vertical, p: padding)
            constraints(in: view, .horizontal, p: padding)
        }
    }
}

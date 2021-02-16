import UIKit

extension UIView {
    fileprivate func extractedFunc(view: UIView) {
        setNeedsLayout()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open func centerMargins(in view: UIView, constant: CGFloat = 0) {
        extractedFunc(view: view)
        let centerY = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        centerY.priority = .defaultHigh
        let centerX = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        centerX.priority = .defaultHigh
        NSLayoutConstraint.activate([ centerY, centerX ])
    }
    open func verticalMargins(in view: UIView, constant: CGFloat = 0) {
        extractedFunc(view: view)
        let top = topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        top.priority = .defaultHigh
        let bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        bottom.priority = .defaultHigh
        NSLayoutConstraint.activate([ top, bottom ])
    }
    open func horizontalMargins(in view: UIView, constant: CGFloat = 0) {
        extractedFunc(view: view)
        let leading = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        leading.priority = .defaultHigh
        let trailing = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
        trailing.priority = .defaultHigh
        NSLayoutConstraint.activate([ leading, trailing ])
    }
    open func allMargins(in view: UIView, constant: CGFloat = 0) {
        extractedFunc(view: view)
        verticalMargins(in: view, constant: constant)
        horizontalMargins(in: view, constant: constant)
    }
}

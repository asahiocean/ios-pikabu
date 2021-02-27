import UIKit

public extension UIImageView {
    func resize(rect: CGRect) {
        guard let image = self.image else { return }
        self.setNeedsLayout()
        let r = image.size.width / image.size.height
        let cs = rect.standardized.integral.size
        self.layer.frame.size = cs.width > cs.height ?
        .init(width: cs.width, height: cs.width / r) :
        .init(width: cs.height * r, height: cs.height)
        self.layoutIfNeeded()
    }
}

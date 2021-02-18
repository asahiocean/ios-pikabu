import UIKit

extension UIImageView {
    final internal func resize(rect: CGRect) {
        guard let image = self.image else { return }
        let r = image.size.width / image.size.height
        let cs = rect.standardized.integral.size
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.layer.frame.size = cs.width > cs.height ?
        .init(width: cs.width, height: cs.width / r) :
        .init(width: cs.height * r, height: cs.height)
    }
}

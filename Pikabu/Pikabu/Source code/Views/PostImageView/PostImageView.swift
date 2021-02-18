import UIKit

open class PostImageView: UIImageView {
    
    open override var bounds: CGRect {
        didSet {
            adjustContentMode()
            layer.borderWidth = 1.5
            layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        }
    }
    
    open override var image: UIImage? {
        didSet {
            adjustContentMode()
        }
    }
    
    fileprivate func adjustContentMode() {
        guard let image = image else { return }
        
        let size = image.size
        
        if size.width > bounds.size.width || size.height > bounds.size.height {
            contentMode = .scaleAspectFit
        } else {
            setNeedsLayout()
            contentMode = .center // or .scaleAspectFill
            self.constraintHeightWidth()
        }
    }
}

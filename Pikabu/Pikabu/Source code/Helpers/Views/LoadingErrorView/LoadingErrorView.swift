import UIKit

open class LoadingErrorView: UIView {
    
    @IBOutlet weak var messageView: UIView!
    
    fileprivate func messageViewShadow() {
        guard let vw = messageView else { return }
        let size: CGFloat = 10
        let dist: CGFloat = 20
        let contact = CGRect(x: -size, y: vw.frame.height - (size * 0.4) + dist, width: vw.frame.width + size * 2, height: size)
        vw.layer.shadowPath = UIBezierPath(ovalIn: contact).cgPath
        vw.layer.shadowRadius = 6
        vw.layer.shadowOpacity = 0.5
        
        let gradient: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor, #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor]
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 1)
            layer.frame = vw.bounds
            return layer
        }()
        vw.layer.insertSublayer(gradient, at: 0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        messageViewShadow()
    }
    
    convenience init(size: CGSize) {
        self.init(frame: CGRect(origin: .zero, size: size))
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        messageViewShadow()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        messageViewShadow()
    }
}

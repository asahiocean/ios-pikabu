import Foundation
import UIKit.UIView

extension UIView.AutoresizingMask {
    public static var totalAll: UIView.AutoresizingMask {
        [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
    }
    public static var widthHeight: UIView.AutoresizingMask {
        [.flexibleWidth, .flexibleHeight]
    }
    
    public static var inflexTopMargin: UIView.AutoresizingMask {
        [.flexibleHeight, .flexibleBottomMargin]
    }
    
    public static var flexVMargin: UIView.AutoresizingMask {
        [.flexibleTopMargin, .flexibleBottomMargin]
    }
    
    public static var flexHMargin: UIView.AutoresizingMask {
        [.flexibleLeftMargin, .flexibleRightMargin]
    }
    
    public static var flexAllMargin: UIView.AutoresizingMask {
        [.flexVMargin, .flexHMargin]
    }
    
    public static var inflexLeftMargin: UIView.AutoresizingMask {
        [.flexibleWidth, .flexibleRightMargin]
    }
    
    public static var inflexRightMargin: UIView.AutoresizingMask {
        [.flexibleWidth, .flexibleLeftMargin]
    }
    
    public static var inflexBottomMargin: UIView.AutoresizingMask {
        [.flexibleHeight, .flexibleTopMargin]
    }
}

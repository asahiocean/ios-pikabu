import UIKit

extension UITableView {
    
    static var separatorColorBackup: UIColor?
    
    open func separatorConfig() {
        Self.separatorColorBackup = separatorColor ?? .clear
        separatorColor = .clear
        let ins = separatorInset.left
        separatorInset = .init(top: 0, left: ins, bottom: 0, right: ins)
    }
}

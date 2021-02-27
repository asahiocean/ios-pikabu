import UIKit

extension UITableView {
    
    static var separatorColorBackup: UIColor?
    
    open func separatorConfig() {
        Self.separatorColorBackup = separatorColor ?? .clear
        separatorColor = .clear
        let i = separatorInset.left
        separatorInset = .init(top: 0, left: i, bottom: 0, right: i)
    }
}

import Foundation
import UIKit

extension UIResponder {
    public func defaultConfig(_ window: UIWindow?) {
        guard let window = window else { fatalError("UIWindow not found") }
        window.rootViewController = NavigationController()
        window.makeKeyAndVisible()
    }
}

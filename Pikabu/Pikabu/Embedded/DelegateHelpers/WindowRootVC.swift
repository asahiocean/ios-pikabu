import UIKit

extension UIResponder {
    func defaultViewController(_ window: UIWindow?, _ viewController: UIViewController) {
        guard let window = window else { fatalError("UIWindow nil") }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

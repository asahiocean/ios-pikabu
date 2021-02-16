import UIKit

extension UIResponder {
    func rootViewController(_ window: UIWindow?, root: UIViewController) {
        guard let window = window else { fatalError("UIWindow nil") }
        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}

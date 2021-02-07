import UIKit

class NavigationController: UINavigationController {
    
    private(set) var root: UIViewController!
    
    override init(rootViewController: UIViewController = FeedVC()) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Init -
    
    convenience init(root: UIViewController) {
        self.init(rootViewController: root)
    }
    
    override init(rootViewController root: UIViewController) {
        super.init(rootViewController: root)
        self.viewControllers = [root]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

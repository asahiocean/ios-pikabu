import UIKit

class ProfileViewController: UIViewController {
    
    static let shared = ProfileViewController()
    
    @IBOutlet weak var usernameImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        usernameImageView.layer.cornerRadius = usernameImageView.bounds.width / 2
    }
}

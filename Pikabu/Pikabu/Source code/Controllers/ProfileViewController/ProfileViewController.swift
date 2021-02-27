import UIKit

class ProfileViewController: UIViewController {
    
    public static let shared: ProfileViewController = .global
    
    @IBOutlet weak var usernameImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var topBar: TopBar!
    @IBOutlet weak var collectionView: ProfileCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameImageView.layer.cornerRadius = usernameImageView.bounds.width / 2
        collectionView.config(with: [.liked,.favorites])
        collectionView.tbdelegate = topBar
        topBar.delegate = collectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameLabel.text = Userinfo.username
        usernameImageView.image = Userinfo.image
    }
}

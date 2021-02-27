import UIKit

class FeedViewController: UIViewController, UITableViewDelegate {
    
    fileprivate var feedView: FeedView!
    internal weak var profile: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedView = .init(view.frame, .posts)
        self.view.addSubview(feedView)
        feedView.model?.updater()
        navigationBarConfig()
        profile = .shared
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedView.reloadData()
    }
}

import UIKit

class FeedViewController: UIViewController {
    
    private var feedView: FeedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        
        feedView = .init(vc: self, .network)
        feedView?.model?.fetch()
        navigationBarConfig()
    }
}

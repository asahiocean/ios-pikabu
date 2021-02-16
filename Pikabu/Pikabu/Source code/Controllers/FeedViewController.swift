import UIKit

class FeedViewController: UIViewController {
    
    private var feedView: FeedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedView = .init(vc: self, .network)
        feedView?.model?.fetch()
        navigationBarConfig()
    }
}

extension FeedViewController: UINavigationControllerDelegate {
    
    @objc fileprivate final func rightAction(_ sender: AnyObject) {
        print("rightAction")
    }
    
    private func navigationBarConfig() {
        guard let nc = navigationController else { fatalError("nil") }
        nc.delegate = self
        navigationItem.title = Bundle.main.appName
        
        // MARK: To customize the button
        let size = nc.navigationBar.bounds.size
        let value: CGFloat = min(size.height, size.width)
        let image = UserInfo.image?.withRenderingMode(.alwaysOriginal)
        
        // MARK: Reference Button Setup
        // This button will serve as a reference,
        // since it has the required dimensions and an embedded image
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.frame.size = .init(width: value, height: value)
        button.imageView?.layer.cornerRadius = button.frame.width / 2
        
        // Assembling the button into the required type
        let barButton = UIBarButtonItem(customView: button)
        
        if let view = barButton.customView {
            // Setting the necessary constraints so that
            // the button does not fill all the available space
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: value),
                view.heightAnchor.constraint(equalToConstant: value)
            ])
        }
        
        if #available(iOS 14.0, *) {
            
            //MARK: value "false" allows you to simultaneously embed in the button UIAction + UIMenu
            button.showsMenuAsPrimaryAction = false
            
            //MARK: Primary action with short touch
            let action = UIAction(title: "action", handler: { (action) in
                print(action)
            })
            button.addAction(action, for: .touchUpInside)
            
            //MARK: Show the menu on the long press
            button.menu = UIMenu(title: "", options: [], children: [
                UIAction(title: "Favorites (\(LocalStorage.shared.feed.count))", image: Icons.star.enable, handler: { (action) in
                    
                }),
                UIAction(title: "Liked (\(LocalStorage.shared.feed.count))", image: Icons.heart.enable, handler: { (action) in
                    
                })
            ])
            
            //MARK: Installing the button in navigation bar
            navigationItem.setRightBarButton(barButton, animated: true)
        } else {
            button.addTarget(self, action: #selector(rightAction(_:)), for: .touchUpInside)
            navigationItem.rightBarButtonItem = barButton
        }
    }
}

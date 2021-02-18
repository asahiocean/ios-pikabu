import UIKit

extension FeedViewController: UINavigationControllerDelegate {
    
    @objc internal final func presentProfile(_ sender: AnyObject?) {
        let profileVC = ProfileViewController.shared
        
        if let nav = navigationController {
            nav.pushViewController(profileVC, animated: true)
        } else {
            present(profileVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation bar config -
    
    internal final func navigationBarConfig() {
        guard let nav = navigationController else { fatalError("nil") }
        nav.delegate = self
        navigationItem.title = Bundle.main.appName
        
        // MARK: To customize the button
        let size = nav.navigationBar.bounds.size
        let value: CGFloat = min(size.height, size.width) * 0.9
        let image = UserInfo.image?.withRenderingMode(.alwaysOriginal)
        
        // MARK: Reference Button Setup
        // This button will serve as a reference,
        // since it has the required dimensions and an embedded image
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.frame.size = .init(width: value, height: value)
        button.imageView?.layer.cornerRadius = button.frame.width / 2
        button.imageView?.layer.borderColor = UIColor.systemGreen.cgColor
        button.imageView?.layer.borderWidth = 1
        
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
            let action = UIAction(title: "action", handler: { [weak self] in
                self?.presentProfile($0)
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
            button.addTarget(self, action: #selector(presentProfile(_:)), for: .touchUpInside)
            navigationItem.rightBarButtonItem = barButton
        }
    }
}

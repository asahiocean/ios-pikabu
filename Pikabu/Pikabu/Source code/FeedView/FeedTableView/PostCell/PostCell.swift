import UIKit

final class PostCell: UITableViewCell, FeedPostCellModel {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var stackView: PostStackView!
    
    private(set) var postInfo: FeedPost!
    
    func setContent(from post: FeedPost) {
        self.stackView.clear()
        
        headerView.photo(UserInfo.image)
        headerView.date(nil) // current date
        
        label?.text = post.title != nil ? post.title : "Пост #\(post.id)"
        
        footerView.commentsCounter.text = "\(post.id)"
        
        if let text = post.body, text.count > 0 {
            let textView = PostTextView(stackView.frame.width, text)
            self.stackView.addArrangedSubview(textView)
        }
        
        post.imagesData.forEach({
            var imageView: UIImageView! {
                didSet {
                    guard let image = imageView.image else { return }
                    // imageView.contentMode = .scaleAspectFit
                    let r = image.size.width / image.size.height
                    let cs = self.stackView.frame.integral.size
                    imageView.frame.size = cs.width > cs.height ?
                    .init(width: cs.width, height: cs.width / r) :
                    .init(width: cs.height * r, height: cs.height)
                    self.stackView.addArrangedSubview(imageView)
                }
            }
            if let data = $0, let image = UIImage(data: data) {
                imageView = .init(image: image)
            } else {
                imageView = .init(image: UIImage(named: "pikabu_fail"))
                imageView.layer.borderColor = UIColor.lightGray.cgColor
                imageView.layer.borderWidth = 1.5
                
                let bl = brokenImage.label(label.font.pointSize)
                brokenImage.report(post, data: $0)
                
                imageView.backgroundColor = .systemGreen
                imageView.addSubview(bl)
                bl.centerMargins(in: imageView)
            }
        })
    }
}


//      guard let image = view.image else { return }
//      let r = image.size.width / image.size.height
//      let cs = self.bounds.standardized.size
//      view.bounds.size = cs.width > cs.height ?
//      .init(width: cs.width, height: cs.width / r) :
//      .init(width: cs.height * r, height: cs.height)
//      super.addArrangedSubview(view)

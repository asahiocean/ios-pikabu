import UIKit

final class PostCell: UITableViewCell, FeedPostCellModel {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var stackView: PostStackView!
    
    private(set) var postInfo: FeedPost!
    
    func content(from post: FeedPost) {
        stackView.removeAllArrangedSubviews()
        
        headerView.photo(UserInfo.image)
        headerView.date(nil) // current date
        
        label?.text = post.title != nil ? post.title : "Пост #\(post.id)"
        
        footerView.commentsCounter.text = "\(post.id)"
        
        //MARK: - Post TextView
        if let text = post.body, text.count > 0 {
            let size = stackView.bounds.standardized.size
            let textView = PostTextView(size, text)
            stackView.append(textView)
        }
        
        //MARK: - Post ImageView
        post.imagesData.forEach({
            if let data = $0, let image = UIImage(data: data) {
                
                let imageView = PostImageView(image: image)
                imageView.backgroundColor = .systemGreen
                self.stackView.append(imageView)
                
            } else if let image = UIImage(named: "pikabu_fail") {
                let imageView = PostImageView(image: image)
                imageView.backgroundColor = #colorLiteral(red: 0.552464664, green: 0.774931848, blue: 0.3732988238, alpha: 1)
                
                let fontSize = label.font.pointSize
                let label = brokenImage.label(fontSize: fontSize)
                brokenImage.report(post, data: $0)
                
                imageView.addSubview(label)
                NSLayoutConstraint.activate([
                    label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -(label.bounds.height / 2)),
                    label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
                ])
                
                self.stackView.append(imageView)
            } else {
                fatalError("Image not found")
            }
        })
    }
}

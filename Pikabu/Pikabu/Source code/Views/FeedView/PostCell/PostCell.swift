import UIKit

class PostCell: UITableViewCell, FeedPostCellModel, FooterDelegate {
    
    @IBOutlet weak var headerView: HeaderView! = .none
    @IBOutlet weak var label: UILabel! = .none
    @IBOutlet weak var stackView: PostStackView! = .none
    @IBOutlet weak var footerView: FooterView! = .none
    
    private(set) internal var post: FeedPost!
    
    fileprivate func constructor(post: FeedPost) {
        
        // MARK: - TextView -
        
        if let text = post.body, text.count > 0 {
            let size = stackView.frame.standardized.size
            let textView = PostTextView(size, text)
            self.stackView.append(textView)
        }
        
        // MARK: - ImageView -
        
        post.imagesData.forEach({
            if let data = $0, let image = UIImage(data: data) {
                //MARK: Downloaded image
                let imageView = PostImageView(image: image)
                self.stackView.append(imageView)
            } else if let image = UIImage(named: "pikabu_fail") {
                //MARK: Dummy image
                let imageView = PostImageView(image: image)
                imageView.backgroundColor = #colorLiteral(red: 0.552464664, green: 0.774931848, blue: 0.3732988238, alpha: 1)
                
                let label = BrokenLabel.shared
                imageView.addSubview(label)
                label.constraints(in: imageView, .horizontal)
                label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,
                                              constant: -(label.bounds.height / 2)).isActive = true
                API.brokenImageReport(post, data: $0)
                
                self.stackView.append(imageView)
            } else {
                fatalError("Image not found")
            }
        })
        
        // MARK: - FooterView -
        
        footerView.commentsCounter.text = "\(post.id)"
        
        DispatchQueue.main.async { [self] in
            let isLiked = Storage.shared.likedList.contains(post.id)
            footerView.likeButton.isSelected = isLiked
            footerView.likeButton.setImage(Icons.isLiked(of: isLiked), for: .normal)
            
            let isFavorited = Storage.shared.favList.contains(post.id)
            footerView.favoriteButton.isSelected = isFavorited
            footerView.favoriteButton.setImage(Icons.isFavorite(of: isFavorited), for: .normal)
        }
    }
    
    func content(from post: FeedPost) {
        stackView.removeAll()
        self.post = post
        
        //MARK: Header
        headerView.photo(image: Userinfo.image)
        headerView.date(nil) // current date
        label.text = post.title != nil ? post.title : "Пост #\(post.id)"
        
        // MARK: Body Constructor
        self.constructor(post: post)
        
        //MARK: Footer
        footerView.delegate = self
    }
    
    func liked(state: Bool) {
        state ? Storage.shared.liked.add(post: post) : Storage.shared.liked.remove(post: post)
    }
    
    func favorites(state: Bool) {
        state ? Storage.shared.favorites.add(post: post) : Storage.shared.favorites.remove(post: post)
    }
    
    fileprivate func setup() {
        backgroundColor = .systemBackground
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

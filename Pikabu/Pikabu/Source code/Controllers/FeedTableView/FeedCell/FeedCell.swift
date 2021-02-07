import UIKit

final class FeedCell: UITableViewCell {
    
    var username: String!
    
    var body: FeedPost!
    
    @IBOutlet weak var imageViewMain: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    private func setImage(_ image: UIImage) {
        contentView.updateConstraintsIfNeeded()
        guard let imageView = self.imageView else { fatalError() }
        imageView.contentMode = .scaleAspectFit
        
        let cvm = titleLabel.layoutMarginsGuide
        let ivm = imageView.layoutMarginsGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ivm.centerXAnchor.constraint(equalTo: cvm.centerXAnchor),
            ivm.topAnchor.constraint(equalTo: cvm.topAnchor, constant: 10.0),
            ivm.leadingAnchor.constraint(greaterThanOrEqualTo: cvm.leadingAnchor, constant: 10.0),
            ivm.trailingAnchor.constraint(greaterThanOrEqualTo: cvm.trailingAnchor, constant: 10.0),
            // ivm.bottomAnchor.constraint(equalTo: cvm.bottomAnchor, constant: 10.0)
        ])
        imageView.image = image
        imageView.backgroundColor = .systemGreen
        contentView.updateConstraints()
    }
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
        
        //        let cvm = contentView.layoutMarginsGuide
        //        let tlm = titleLabel.layoutMarginsGuide
        //        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            tlm.centerXAnchor.constraint(equalTo: cvm.centerXAnchor),
        //            tlm.topAnchor.constraint(equalTo: cvm.topAnchor, constant: 10.0),
        //            tlm.leadingAnchor.constraint(equalTo: cvm.leadingAnchor, constant: 10.0),
        //            tlm.trailingAnchor.constraint(equalTo: cvm.trailingAnchor, constant: -10.0)
        //            // tlm.bottomAnchor.constraint(equalTo: cvm.bottomAnchor, constant: 10.0)
        //        ])
        //        titleLabel.sizeToFit()
        //        titleLabel.backgroundColor = .systemYellow
    }
    
    func setBody(_ title: String?) {
        if let title = title {
            bodyLabel?.isHidden = false
            bodyLabel?.text = title
        } else {
            bodyLabel?.removeFromSuperview()
        }
    }
    
    func config(_ feed: FeedPost) {
        guard Thread.isMainThread else { fatalError() }
        setTitle(feed.title)
        setBody(feed.body)
        
        feed.imagesData.enumerated().forEach({ (index,data) -> Void in
            if let data = data, let image = UIImage(data: data) {
                // self.setImage(image)
                imageViewMain.image = image
            } else {
                self.backgroundColor = .systemRed
            }
        })
        layoutIfNeeded()
        setNeedsLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoresizingMask = [.flexibleWidth,.flexibleHeight]
        backgroundColor = .systemBackground
        layoutIfNeeded()
        setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

import UIKit

class ScreenCell: UICollectionViewCell {
    
    private weak var feedView: FeedView!
    
    func config(with feed: FeedView) {
        self.feedView = feed
        contentView.addSubview(feedView)
        feedView.constraints(in: contentView, .all)
    }
}

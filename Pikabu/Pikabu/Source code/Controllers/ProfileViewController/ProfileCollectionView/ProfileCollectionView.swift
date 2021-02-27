import UIKit

class ProfileCollectionView: UICollectionView, PageDelegate {
    
    private var feeds: [FeedView] = []
    weak var tbdelegate: TBDelegate?
    
    func page(i indexPath: IndexPath) {
        self.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        self.deselectItem(at: indexPath, animated: false)
    }
    
    func config(with feedType: [FeedType]) {
        feedType.forEach({
            let feed = FeedView(frame, $0)
            feed.model?.updater()
            feeds.append(feed)
        })
        dataSource = self
        delegate = self
    }
    
    fileprivate func collectionViewLayoutConfig() {
        self.setNeedsLayout()
        let layout = collectionViewLayout
        switch layout {
        case let layout as UICollectionViewFlowLayout:
            layout.scrollDirection = .horizontal
            
            layout.minimumInteritemSpacing = .zero
            layout.minimumLineSpacing = .zero
            
            layout.itemSize = frame.standardized.size
        default:
            fatalError("СollectionViewLayout of a different type")
        }
    }
    
    fileprivate func setup() {
        self.collectionViewLayoutConfig()
        register(ScreenCell.self, forCellWithReuseIdentifier: ScreenCell.id)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
}

//MARK: - Extension Collection View -

extension ProfileCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.standardized.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenCell.id, for: indexPath) as! ScreenCell
        cell.config(with: feeds[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        feeds[indexPath.item].reloadData()
    }
}

//MARK: - Extension Scroll View -

extension ProfileCollectionView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tbdelegate?.move(to: scrollView.contentOffset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        tbdelegate?.tabIndex(i: .init(item: Int(targetContentOffset.pointee.x / scrollView.frame.width), section: 0))
    }
}

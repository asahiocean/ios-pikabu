import UIKit

class TopBar: UIView, TBDelegate {
    
    // delegate to select the required page in ProfileCollectionView
    weak var delegate: PageDelegate?
    
    fileprivate var tabIndex = IndexPath(item: 0, section: 0)
    fileprivate var tabs = ["Liked","Favorites"]
    
    // CollectionView will provide the user with the ability to switch to the desired tab
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TBCell.self, forCellWithReuseIdentifier: TBCell.id)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        collectionView.constraints(in: self, .all)
        return collectionView
    }()
    
    private lazy var indicator: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        
        self.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.heightAnchor.constraint(equalToConstant: 6),
            
            //MARK: - Fix: 'NSInternalInconsistencyException', reason: 'Multiplier is not finite!  That's illegal.  multiplier:inf'
            //MARK: Answer: value 'multiplier' should not be equal 0 !!! -
            indicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / CGFloat(tabs.count)),
            indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return indicator
    }()
    
    func tabIndex(i index: IndexPath) {
        collectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.page(i: index)
        tabIndex = index
    }
    
    func move(to point: CGPoint) { indicator.frame.origin.x = point.x / CGFloat(tabs.count) }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [self] in
            if let cell = collectionView.cellForItem(at: tabIndex) {
                indicator.frame.origin.x = cell.frame.minX
            }
            // keeping the position of the indicator on the tab
            // when changing to light/dark mode interface
            tabIndex(i: tabIndex)
        }
    }
}

//MARK: - CollectionView config -

extension TopBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabIndex(i: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TBCell.id, for: indexPath) as! TBCell
        cell.label.text = tabs[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(tabs.count)
        return .init(width: width, height: frame.height)
    }
}

import UIKit

protocol TopBarListener {
    func scrollToBarIndex(index: Int)
}

class TopBar: UIView {
    
    private weak var collectionView: UICollectionView!
    private weak var selectedTabIndicator: UIView?
    private var tabsNames: [String] = []
    private var tabsSize: Int { tabsNames.count }
    private var listener: TopBarListener?
    
    func configure(tabsNames: [String], listener: TopBarListener? = nil, selectedItem: Int = 0){
        self.tabsNames = tabsNames
        self.listener = listener
        
        if tabsSize == 0 {
            #if DEBUG
            fatalError() //tabsNames should not be empty
            #else
            tabsNames = [""]
            #endif
        }
        
        setupSelectedTabIndicator()
        
        selectItem(selectedItem, animated: false)
    }
    
    func invalidateLayout(){
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func selectItem(_ index: Int, animated: Bool = true){
        guard index >= 0, index < tabsSize else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: .centeredHorizontally)
    }
    
    func moveIndicator(_ x: CGFloat){
//        selectedTabIndicator?.snp.updateConstraints { (make) in
//            make.left.equalToSuperview().offset((collectionView.frame.width * x) / CGFloat(tabsSize))
//        }
    }
    
    private func setupSelectedTabIndicator() {
        if let selectedTabIndicator = selectedTabIndicator {
            selectedTabIndicator.removeFromSuperview()
        }
        let selectedTabIndicator = UIView()
        selectedTabIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        selectedTabIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectedTabIndicator)
        
        selectedTabIndicator.widthAnchor.constraint(
            equalTo: self.widthAnchor, multiplier: 1 / CGFloat(tabsSize)
        ).isActive = true
        
//        selectedTabIndicator.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(6)
//        }
        
        self.selectedTabIndicator = selectedTabIndicator
    }
    
    private func setupColletionView(){
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BarCell.self, forCellWithReuseIdentifier: BarCell.identifier)
        
        addSubview(collectionView)
        
//        collectionView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        
        self.collectionView = collectionView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColletionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.scrollToBarIndex(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabsSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BarCell.identifier, for: indexPath) as! BarCell
        cell.tabLbl.text = tabsNames[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(tabsSize), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


class BarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    static let identifier = "BarCell"
    
    weak var tabLbl: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            tabLbl.textColor = isHighlighted ? .white : UIColor.white.withAlphaComponent(0.7)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            tabLbl.textColor = isSelected ? .white : UIColor.white.withAlphaComponent(0.7)
        }
    }
    
    func setupViews() {
        let tabLbl = UILabel()
        addSubview(tabLbl)
        
        tabLbl.textAlignment = .center
        tabLbl.textColor = UIColor.white.withAlphaComponent(0.7)
        
//        tabLbl.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalToSuperview().offset(6)
//            make.height.equalTo(40)
//        }
        self.tabLbl = tabLbl
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

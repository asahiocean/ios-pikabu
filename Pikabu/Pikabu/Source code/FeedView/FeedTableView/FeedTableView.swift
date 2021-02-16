import UIKit

class FeedView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var model: FeedModel?
    
    //MARK: - Init -
    
    convenience init(vc: UIViewController, _ storage: StorageType) {
        self.init(frame: vc.view.frame, style: .plain)
        self.model = .init(self, storage.config)
        vc.view.insertSubview(self, at: 0)
    }
    
    @objc func addTapped() {
        print("addTapped")
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(PostCell.nib, forCellReuseIdentifier: PostCell.reuseId)
        
        dataSource = self
        delegate = self
        
        decelerationRate = .fast
        separatorStyle = .none
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = UITableView.automaticDimension
        
        insetsContentViewsToSafeArea = true
        insetsLayoutMarginsFromSafeArea = true
        contentInsetAdjustmentBehavior = .automatic
        adjustedContentInsetDidChange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TableView data source -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.storage?.feed != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feed = model?.storage?.feed, feed.count > 0 else {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.startAnimating()
            backgroundView = indicator
            return 0
        }
        backgroundView = nil
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as! PostCell
        if let post = model?.storage?.getPost(indexPath) {
            cell.setContent(from: post)
        } else {
            fatalError("Post not found!")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:", indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

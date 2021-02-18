import UIKit

class FeedView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var model: FeedModel?
    
    //MARK: - Init -
    
    convenience init(vc: UIViewController, _ storage: StorageType) {
        self.init(frame: vc.view.frame, style: .plain)
        self.model = .init(self, storage.config)
        vc.view.insertSubview(self, at: 0)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(PostCell.nib, forCellReuseIdentifier: PostCell.reuseId)
        
        dataSource = self
        delegate = self
        
        decelerationRate = .fast
        
        separatorConfig()
        
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
        guard model?.storage?.feed != nil else {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feed = model?.storage?.feed, feed.count > 0 else {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.startAnimating()
            tableView.backgroundView = indicator
            return 0
        }
        tableView.backgroundView = nil
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseId, for: indexPath) as! PostCell
        if let post = model?.storage?.getPost(indexPath) {
            cell.content(from: post)
        } else {
            fatalError("Post not found!")
        }
        cell.contentView.setNeedsLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutIfNeeded()
        tableView.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:", indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

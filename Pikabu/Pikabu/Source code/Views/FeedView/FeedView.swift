import UIKit

class FeedView: UITableView {
    
    private(set) internal var model: FeedModel?
    
    convenience init(_ frame: CGRect, _ storage: FeedType) {
        self.init(frame: frame, style: .plain)
        self.model = .init(self, storage)
        register(PostCell.nib, forCellReuseIdentifier: PostCell.id)
        delegate = self; dataSource = self
        decelerationRate = .fast
        self.separatorConfig()
    }
}

//MARK: - FeedView's Table View -

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.storage.config.feed.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as! PostCell
        if let post = model?.storage.config.receive(post: indexPath) {
            cell.content(from: post)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

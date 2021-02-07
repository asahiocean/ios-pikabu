import UIKit

final class FeedTableView: UITableView {
    
    fileprivate func setupFunc() {
        register(FeedCell.nib, forCellReuseIdentifier: FeedCell.reuseId)
        
        estimatedRowHeight = UITableView.automaticDimension
        rowHeight = UITableView.automaticDimension
        decelerationRate = .fast
        
        tableFooterView = .init() // Hiding unused table cells
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupFunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

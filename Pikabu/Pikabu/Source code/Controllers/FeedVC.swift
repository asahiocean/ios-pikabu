import Foundation
import UIKit

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath ->", indexPath)
        tableView.beginUpdates()
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseId, for: indexPath) as? FeedCell {
            if let feed = storage.getting() {
                let post = feed[indexPath.row]
                cell.config(post)
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            tableView.endUpdates()
            return cell
        } else {
            fatalError("Check UITableViewCell!")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let posts = storage.getting() else { return 0 }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:", indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class FeedVC: UIViewController {
    
    private(set) var tableView: UITableView!
    private(set) var storage: NetworkStorage!
    
    fileprivate func feedRequest() {
        let (queue,group) = (Dispatcher.queues.self,Dispatcher.groups.self)
        group.request.enter()
        queue.request.async(group: group.request, execute: {
            [weak self] () -> Void in
            API.get(to: URLS.feed, with: {
                do {
                    guard let data = try $0.get() else { return }
                    Handler.shared.worker(data) { (result: Result<[FeedPost]?,Error>) in
                        do {
                            if let posts = try result.get() {
                                DispatchQueue.main.async {
                                    self?.storage.setting(posts)
                                }
                            }
                        } catch {
                            fatalError("Couldn't fetch data using model")
                        }
                    }
                } catch {
                    fatalError(error.localizedDescription)
                }
            })
        })
        group.request.notify(queue: .main, execute: {
            [weak self] () -> Void in
            self?.tableView.reloadData()
            print("group.request.notify")
            if let posts = self?.storage.getting() {
                API.post(with: ["Post IDs": posts.map({$0.id})])
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Bundle.main.appName
        storage = NetworkStorage.shared
        
        tableView = FeedTableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let indicator = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = indicator
        indicator.startAnimating()
        
        feedRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: nil)
    }
}

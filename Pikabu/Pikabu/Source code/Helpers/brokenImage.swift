import UIKit

enum brokenImage {
    
    static func label(_ fontSize: CGFloat = 18) -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        label.font = .boldSystemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Упс, эта картинка сломалась :(" + "\n" + "Мы скоро это починим!"
        label.sizeToFit()
        return label
    }
    
    static func report(_ post: FeedPost, data: Data?) {
        if let i = post.imagesData.firstIndex(of: data) {
            DispatchQueue.global(qos: .utility).async {
                let dict: Dictionary = [
                    "POST ID": post.id,
                    "POST URL": URLS.postID(post.id),
                    "IMAGE URL": post.images?[i] as Any]
                API.post(with: ["BROKEN_IMAGE": dict])
            }
        }
    }
}

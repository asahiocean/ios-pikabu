import UIKit

enum brokenImage {
    
    static func label(fontSize: CGFloat = 18) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.6525524215)
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

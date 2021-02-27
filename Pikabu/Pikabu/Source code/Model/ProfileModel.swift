import UIKit

protocol ProfileModel {
    var usernameImageView: UIImageView! { get }
    var usernameLabel: UILabel! { get }
    var topBar: TopBar! { get }
    var collectionView: ProfileCollectionView! { get }
}

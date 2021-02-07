import Foundation

protocol CacheProvider {
    subscript(key: String) -> Data? { get set }
    var memory: CacheHandler { get }
    var disk: CacheHandler { get }
    var ud: UserDefaults { get }
    func remove()
}

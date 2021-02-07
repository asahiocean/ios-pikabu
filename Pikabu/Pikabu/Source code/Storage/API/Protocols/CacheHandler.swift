import Foundation

protocol CacheHandler {
    func load(_ key: String) -> Data?
    func save(_ key: String, _ data: Data)
    func remove()
}

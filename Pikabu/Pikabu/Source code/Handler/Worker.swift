import Foundation

protocol Worker {
    func worker<T>(_ data: Data, _ completion: @escaping (Result<T?,Error>)->()) where T: AnyCodable
}

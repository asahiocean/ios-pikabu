import Foundation

protocol Worker {
    func worker<T>(_ data: Data, _ completion: @escaping (Result<T?,Error>)->()) where T: AnyCodable
}

class Handler: Worker {
    
    static let shared = Handler()
    
    /// Function for processing data
    /// - Parameter data: Data that needs to be processed for subsequent output
    func worker<T>(_ data: Data, _ completion: @escaping (Result<T?,Error>)->()) where T : AnyCodable {
        // Working with the received data
        if let data = data as? T { // If you want to get raw data
            completion(.success(data))
        } else { // Otherwise, try to decode the data through the required model
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let model = try decoder.decode(T?.self, from: data)
                switch model {
                case let feeds as [FeedPost]:
                    for i in feeds.indices { //MARK: Loading images for posts
                        guard let urls = feeds[i].images else { continue }
                        urls.forEach({
                            let data = try? Data(contentsOf: URL(string: $0)!)
                            feeds[i].imagesData.append(data)
                        })
                        if i == feeds.endIndex - 1 {
                            completion(.success(feeds as? T))
                        }
                    }
                default:
                    completion(.success(model))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    fileprivate init() { }
}

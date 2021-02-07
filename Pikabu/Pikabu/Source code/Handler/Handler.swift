import Foundation

final class Handler: Worker {
    
    static let shared = Handler()
    
    /// Function for processing data
    /// - Parameter data: Data that needs to be processed for subsequent output
    internal func worker<T>(_ data: Data, _ completion: @escaping (Result<T?,Error>)->()) where T : AnyCodable {
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
                case var feeds as [FeedPost]:
                    for i in feeds.indices { //MARK: Loading images for posts
                        guard let urls = feeds[i].images else { continue }
                        for url in urls {
                            let data = try? Data(contentsOf: URL(string: url)!)
                            feeds[i].imagesData.append(data)
                            if i == feeds.endIndex - 1 {
                                completion(.success(feeds as? T))
                            }
//                            API.get(to: url, with: { (result: Result<Data?,Error>) in
//                                do {
//                                    let data = try result.get()
//                                    feeds[i].imagesData.append(data)
//                                    if i == feeds.endIndex - 1 {
//                                        completion(.success(feeds as? T))
//                                    }
//                                } catch {
//                                    fatalError("FAIL LOAD IMAGE: \(url)\n\(error.localizedDescription)")
//                                }
//                            })
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

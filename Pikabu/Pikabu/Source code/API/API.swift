import Foundation

struct API: GETPOST {
    
    static private let storage = APIStorage.shared
    
    static func get(to urlStr: String, with completion: @escaping NetworkResult) {
        let (queue,group) = (Dispatcher.queues.self,Dispatcher.groups.self)
        group.get.enter()
        queue.get.async(group: group.get, execute: { () -> Void in
            guard let url: URL = URL(string: urlStr) else { fatalError("Failed to create URL") }
            var request: URLRequest = URLRequest(url: url)
            self.requestConfig(&request, .get)
            
            let config: URLSessionConfiguration = .ephemeral
            config.waitsForConnectivity = true
            
            if let data: Data = APIStorage.shared[urlStr] { // Retrieving cached data from
                completion(.success(data))
            } else {
                let task = URLSession(configuration: config).dataTask(with: request) { (data,response,error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let data: Data = data { // Receiving new downloaded data
                        APIStorage.shared[urlStr] = data
                        completion(.success(data))
                    }
                }
                task.resume()
            }
        })
    }
    
    static func post(to urlStr: String = URLS.postRequest, with postbody: [String:Any], _ completion: (NetworkResult)? = nil) {
        let (queue,group) = (Dispatcher.queues.self,Dispatcher.groups.self)
        group.post.enter()
        queue.post.async(group: group.post, execute: {
            guard let url: URL = URLS.encoder(urlStr) else { fatalError("Failed to create URL") }
            var request: URLRequest = URLRequest(url: url)
            self.requestConfig(&request, .post)
            
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONSerialization.data(withJSONObject: postbody, options: [.prettyPrinted])
                
                //MARK: POST Authorization
                let username = "xvhuqdph" // Caesar cipher ROT3
                let password = "sdvvzrug"
                
                let loginString = String(format: "%@:%@", username, password)
                let loginData: Data = loginString.data(using: .utf8)!
                let base64: String = loginData.base64EncodedString()
                let basic: String = "Basic \(base64)"
                request.setValue(basic, forHTTPHeaderField: "Authorization")
                
                let task = URLSession.shared.dataTask(with: request) { data,_,_ in
                    guard let completion = completion else { return }
                    completion(.success(data))
                    group.post.leave()
                }
                task.resume()
            } catch {
                fatalError(error.localizedDescription)
            }
        })
    }
    fileprivate init() { }
}

extension API {
    fileprivate enum Method: String, CustomStringConvertible, CaseIterable {
        case get = "GET"
        case post = "POST"
        var description: String { get { self.rawValue } }
        
        init(_ value: String) {
            switch value.lowercased() {
            case "get": self = .get
            case "post": self = .post
            default: self = .get
            }
        }
    }
    
    static fileprivate func requestConfig(_ request: inout URLRequest, _ method: Method) {
        request.httpMethod = method.rawValue
        request.timeoutInterval = .zero
        request.networkServiceType = .background
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
}

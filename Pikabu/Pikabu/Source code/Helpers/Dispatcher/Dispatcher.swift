import Foundation
import Dispatch

public enum Dispatcher {
    enum groups {
        static let get = DispatchGroup()
        static let post = DispatchGroup()
        static let request = DispatchGroup()
        static let jsonDecoder = DispatchGroup()
    }
    enum queues {
        static let get = DispatchQueue(label: "com.get.queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
        static let post = DispatchQueue(label: "com.post.queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
        static let request = DispatchQueue(label: "com.request.queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
        static let jsonDecoder = DispatchQueue(label: "com.api.jsonDecoder", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
        static let monitor = DispatchQueue(label: "com.monitor.queue")
    }
    enum operQueue {
        static let request = OperationQueue()
        static let network = OperationQueue()
        static let jsonDecoder = OperationQueue()
    }
}

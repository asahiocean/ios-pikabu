import Dispatch

public enum Dispatcher {
    enum groups {
        static let get = DispatchGroup()
        static let post = DispatchGroup()
    }
    enum queues {
        static let get = DispatchQueue(label: "com.get.queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
        static let post = DispatchQueue(label: "com.post.queue", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem)
    }
}

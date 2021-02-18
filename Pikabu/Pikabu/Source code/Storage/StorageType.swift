import Foundation

enum StorageType {
    case network
    case local
    
    public var config: StorageModel {
        switch self {
        case .network: return  NetworkStorage.shared
        case .local: return NetworkStorage.shared
        }
    }
}

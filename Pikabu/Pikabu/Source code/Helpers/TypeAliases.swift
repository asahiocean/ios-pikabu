import Foundation

typealias AnyCodable = Any & Codable
typealias NetworkResult = (Result<Data?,Error>)->()

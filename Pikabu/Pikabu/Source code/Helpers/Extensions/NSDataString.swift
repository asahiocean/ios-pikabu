import Foundation

extension String {
    func ns() -> NSString { NSString(string: self) }
}
extension Data {
    func ns() -> NSData { NSData(data: self) }
}

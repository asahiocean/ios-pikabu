import Foundation

protocol GETPOST {
    static func get(to urlStr: String, with completion: @escaping NetworkResult)
    static func post(to urlStr: String, with postbody: [String:Any], _ completion: NetworkResult?)
}

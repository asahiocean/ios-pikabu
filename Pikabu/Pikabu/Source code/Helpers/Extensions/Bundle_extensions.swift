import Foundation

extension Bundle {
    var appName: String {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String ?? "temp"
    }
}

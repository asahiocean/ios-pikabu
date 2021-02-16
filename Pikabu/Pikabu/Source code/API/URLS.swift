import Foundation

public enum URLS {
    static let host = "https://pikabu.ru"
    static let feed = host + "/page/interview/mobile-app/test-api/feed.php"
    static let story = host + "/page/interview/mobile-app/test-api/story.php?id="
    static func postID(_ id: Int) -> String { host + "/page/interview/mobile-app/test-api/story.php?id=\(id)" }
    
    //MARK: -- Link for POST request
    static let postRequest: String = "https://ptsv2.com/t/asahiocean_pikabu/post"
    
    static func encoder(_ str: String) -> URL? {
        URL(string: str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? str.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? str)
    }
}

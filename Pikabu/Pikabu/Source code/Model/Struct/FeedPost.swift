import Foundation

@objc class FeedPost: NSObject, AnyCodable {
    
    let id: Int
    let title: String?
    let images: [String]?
    let body: String?
    
    var imagesData: [Data?] = []
    
    internal init(id: Int, title: String, images: [String], body: String) {
        self.id = id
        self.title = title
        self.images = images
        self.body = body
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case images = "images"
        case body = "body"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? .init()
        images = try values.decodeIfPresent([String].self, forKey: .images) ?? .init()
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? .init()
        body = try values.decodeIfPresent(String.self, forKey: .body) ?? .init()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encodeIfPresent(body, forKey: .body)
    }
}

extension FeedPost { // Equatable extension
    static func == (lhs: FeedPost, rhs: FeedPost) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.images == rhs.images && lhs.body == rhs.body
    }
}

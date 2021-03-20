import Foundation

struct EventsModel: Codable {
    let id: Int
    let title: String
    let start: String?
    let end: String?
    let thumbnail: Thumbnail
    let comics: Comics
    
    // Custom
    var isOpened: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, start, end, thumbnail, comics
    }
}

extension EventsModel {
    
    mutating func open() {
        isOpened = true
    }
    
    mutating func close() {
        isOpened     = false
    }
}

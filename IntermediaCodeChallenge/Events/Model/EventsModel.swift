import Foundation

struct EventsModel: Codable {
    let id: Int
    let title: String
    let start: String?
    let end: String?
    let thumbnail: Thumbnail
}

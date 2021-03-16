import Foundation

struct HeroesModel: Codable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let fileExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}

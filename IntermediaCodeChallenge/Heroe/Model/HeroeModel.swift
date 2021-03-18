import Foundation

struct HeroeModel: Codable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: Thumbnail
    let comics: Comics
}

struct Comics: Codable {
    let items: [ComicsItems]
}

struct ComicsItems: Codable {
    let name: String
}

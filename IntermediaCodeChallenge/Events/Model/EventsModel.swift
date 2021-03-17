import Foundation

struct EventsModel: Codable {
    let id: Int
    let title: String
    let start: String
    let end: String
}

extension EventsModel {
    
    func transformDate() -> String {
        
        return ""
    }
}

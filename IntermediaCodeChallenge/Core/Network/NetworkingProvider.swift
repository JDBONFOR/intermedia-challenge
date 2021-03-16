import Foundation
import Alamofire

final class NetworkingProvider {
    static let shared = NetworkingProvider()
    
    // GetData
    func fetchData<T: Codable>(url: String, callback: @escaping (T?, AFError?) -> Void) {
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<409)
            .responseDecodable(of: T.self) { response in
                
                if let response = response.value {
                    callback(response, nil)
                } else {
                    callback(nil, response.error)
                }
            }
    }
}

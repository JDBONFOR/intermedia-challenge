import Foundation

protocol SuperheroesViewModelProtocol: class {
    func finishLoadData()
}

public class SuperheroesViewModel {
    
    var dataSource: [HeroesModel] = []
    var delegate: SuperheroesViewModelProtocol?
    
    init() { }
    
}

// MARK: - Extensions
extension SuperheroesViewModel {
    
    func fetchData() {
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.heroes] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: [Constants.key, Constants.hash])
        let url = Constants.baseUrl + urlFormatted
        
        NetworkingProvider.shared.fetchData(url: url) { (result: RequestResponseWrapperModel<RequestResponseDataWrapperModel<HeroesModel>>?, error) in
            if let error = error {
                print("Error ==> \(error)")
            } else if let result = result {
                self.dataSource = result.data.results
                self.delegate?.finishLoadData()
            }
        }
    }
}

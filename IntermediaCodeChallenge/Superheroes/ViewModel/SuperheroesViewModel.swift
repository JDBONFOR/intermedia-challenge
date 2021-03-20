import Foundation

protocol SuperheroesViewModelProtocol: class {
    func showError(_ error: Error)
    func finishLoadData()
}

public class SuperheroesViewModel {
    
    var dataSource: [HeroesModel] = []
    var delegate: SuperheroesViewModelProtocol?
    var isLoading: Bool = false
    var totalItems: Int = 0
    var limit: Int = 20
    var isMoreDataLoading: Bool = false
    
    init() { }
    
}

// MARK: - Extensions
extension SuperheroesViewModel {
    
    func fetchData(limit: Int) {
        
        isLoading = true
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.heroes] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: [Constants.key, Constants.hash, String(limit)])
        let url = Constants.baseUrl + urlFormatted
        
        NetworkingProvider.shared.fetchData(url: url) { (result: RequestResponseWrapperModel<RequestResponseDataWrapperModel<HeroesModel>>?, error) in
            
            self.isLoading = false
            self.isMoreDataLoading = false
                        
            if let error = error {
                self.delegate?.showError(error)
            } else if let result = result {
                self.totalItems = result.data.total
                self.dataSource = result.data.results
                self.delegate?.finishLoadData()
            }
        }
    }
}

import Foundation

protocol EventsViewModelProtocol: class {
    func showError(_ error: Error)
    func finishLoadData()
}

public class EventsViewModel {
    
    var dataSource: [EventsModel] = []
    var titleDataSource: [TitleSectionHeroeCellViewModel] = []
    var delegate: EventsViewModelProtocol?
    var isLoading: Bool = false
    var totalItems: Int = 0
    var limit: Int = 20
    var isMoreDataLoading: Bool = false
    
    init() { }
    
}

// MARK: - Extensions
extension EventsViewModel {
    
    func fetchData(limit: Int) {
        
        isLoading = true
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.events] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: [Constants.key, Constants.hash, String(limit)])
        let url = Constants.baseUrl + urlFormatted
        
        print("Events URL ==> \(url)")
        
        NetworkingProvider.shared.fetchData(url: url) { (result: RequestResponseWrapperModel<RequestResponseDataWrapperModel<EventsModel>>?, error) in
            
            self.isLoading = false
            self.isMoreDataLoading = false
            
            if let error = error {
                self.delegate?.showError(error)
            } else if let result = result {
                self.createTitleSection()
                self.totalItems = result.data.total
                self.dataSource = result.data.results
                self.delegate?.finishLoadData()
            }
        }
        
    }
    
    func createTitleSection() {
        let title = "comics a discutir"
        self.titleDataSource.append(TitleSectionHeroeCellViewModel(title: title.uppercased()))
    }
    
}

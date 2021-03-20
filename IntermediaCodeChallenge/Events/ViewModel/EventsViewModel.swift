import Foundation

protocol EventsViewModelProtocol: class {
    func finishLoadData()
}

public class EventsViewModel {
    
    var dataSource: [EventsModel] = []
    var titleDataSource: [TitleSectionHeroeCellViewModel] = []
    var delegate: EventsViewModelProtocol?
    
    init() { }
    
}

// MARK: - Extensions
extension EventsViewModel {
    
    func fetchData() {
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.events] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: [Constants.key, Constants.hash])
        let url = Constants.baseUrl + urlFormatted
        
        NetworkingProvider.shared.fetchData(url: url) { (result: RequestResponseWrapperModel<RequestResponseDataWrapperModel<EventsModel>>?, error) in
            if let error = error {
                
                print("Error ==> \(error)")
                
            } else if let result = result {
                self.createTitleSection()
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

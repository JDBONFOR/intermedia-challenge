import Foundation
import SDWebImage

protocol HeroeViewModelProtocol: class {
    func finishLoadData()
}

public class HeroeViewModel {
    
    var idHeroe: Int
    var titleNavigator: String = ""
    var headerDataSource: [HeaderSectionHeroeCellViewModel] = []
    var titleDataSource: [TitleSectionHeroeCellViewModel] = []
    var comicsDataSource: [ComicsSectionHeroeCellViewModel] = []
    var delegate: HeroeViewModelProtocol?
    
    init(id: Int) {
        self.idHeroe = id
    }
}

// MARK: - Extension
extension HeroeViewModel {
    
    func fetchData() {
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.heroe] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: [String(idHeroe), Constants.key, Constants.hash])
        let url = Constants.baseUrl + urlFormatted
        
        NetworkingProvider.shared.fetchData(url: url) { (result: RequestResponseWrapperModel<RequestResponseDataWrapperModel<HeroeModel>>?, error) in
            if let error = error {
                print("Error ==> \(error)")
            } else if let result = result, let heroe = result.data.results.first {
                
                let imageUrl = heroe.thumbnail.path + "." + heroe.thumbnail.fileExtension
                self.headerDataSource.append(HeaderSectionHeroeCellViewModel(imageUrl: imageUrl, description: heroe.description ?? ""))
                
                let title = "Comics en los que aparece:"
                self.titleDataSource.append(TitleSectionHeroeCellViewModel(title: title.uppercased()))
                
                heroe.comics.items.forEach { comic in
                    self.comicsDataSource.append(ComicsSectionHeroeCellViewModel(title: comic.name, date: ""))
                }
                
                self.titleNavigator = heroe.name
                
                self.delegate?.finishLoadData()
                
            }
        }
    }    
}

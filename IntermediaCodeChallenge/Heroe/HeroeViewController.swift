import UIKit

class HeroeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var viewModel: HeroeViewModel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.showLoader(in: self)
        setupUI()
        fetchData()
    }

}

// MARK: - Private Methods
private extension HeroeViewController {
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        viewModel.delegate = self
                
        // Register Cell
        tableView.register(UINib(nibName: "HeaderSectionHeroeCell", bundle: nil), forCellReuseIdentifier: "HeaderSectionHeroeCell")
        tableView.register(UINib(nibName: "TitleSectionHeroeCell", bundle: nil), forCellReuseIdentifier: "TitleSectionHeroeCell")
        tableView.register(UINib(nibName: "ComicsSectionHeroeCell", bundle: nil), forCellReuseIdentifier: "ComicsSectionHeroeCell")
    }
    
    func fetchData() {
        
        viewModel.fetchData()
    }
}

// MARK: - Extensions
// UITableViewDelegate, UITableViewDataSource
extension HeroeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.headerDataSource.count
        }
        else if section == 1 {
            return viewModel.titleDataSource.count
        }
        else {
            return viewModel.comicsDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSectionHeroeCell", for: indexPath) as? HeaderSectionHeroeCell else { return UITableViewCell() }
            let data = viewModel.headerDataSource[indexPath.row]
            
            cell.setupCell(HeaderSectionHeroeCellViewModel(imageUrl: data.imageUrl, description: data.description))
            return cell
        
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSectionHeroeCell", for: indexPath) as? TitleSectionHeroeCell else { return UITableViewCell() }
            let data = viewModel.titleDataSource[indexPath.row]
            
            cell.setupCell(TitleSectionHeroeCellViewModel(title: data.title))
            return cell
        
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsSectionHeroeCell", for: indexPath) as? ComicsSectionHeroeCell else { return UITableViewCell() }
            let data = viewModel.comicsDataSource[indexPath.row]
            
            cell.setupCell(ComicsSectionHeroeCellViewModel(title: data.title, date: ""))
            return cell
        
        }
    }    
}

// HeroeViewModelProtocol
extension HeroeViewController: HeroeViewModelProtocol {
 
    func showLoader() {
        Utils.showLoader(in: self)
    }
    
    func hideLoader() {
        Utils.hideLoader(in: self)
    }
    
    func finishLoadData() {
        
        navigationItem.title = viewModel.titleNavigator
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        
        tableView.reloadData()
    }
}

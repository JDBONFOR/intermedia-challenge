import UIKit

class EventsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private var viewModel: EventsViewModel = EventsViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }

}

// MARK: - Private Methods
private extension EventsViewController {
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        viewModel.delegate = self
        
        // Register Cell
        tableView.register(UINib(nibName: "HeaderSectionEventsCell", bundle: nil), forCellReuseIdentifier: "HeaderSectionEventsCell")
        tableView.register(UINib(nibName: "TitleSectionHeroeCell", bundle: nil), forCellReuseIdentifier: "TitleSectionHeroeCell")
        tableView.register(UINib(nibName: "ComicsSectionHeroeCell", bundle: nil), forCellReuseIdentifier: "ComicsSectionHeroeCell")
        
    }
    
    func fetchData() {
        viewModel.fetchData(limit: viewModel.limit)
    }
    
}

// MARK: - Extensions
// UITableViewDelegate, UITableViewDataSource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.dataSource[section].isOpened {
            let rows = viewModel.dataSource[section].comics.items.count + viewModel.titleDataSource.count
            return rows
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderSectionEventsCell") as? HeaderSectionEventsCell else { return UITableViewCell() }
            
            let data = viewModel.dataSource[indexPath.section]
            let imageUrl: String = data.thumbnail.path + "." + data.thumbnail.fileExtension
            let model = HeaderSectionEventsCellViewModel(isOpened: data.isOpened, title: data.title, startDate: data.start, dueDate: data.end, imageUrl: imageUrl)
            cell.setupCell(model)
            return cell
         
        } else if indexPath.row == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSectionHeroeCell") as? TitleSectionHeroeCell else { return UITableViewCell() }
            let data = viewModel.titleDataSource[indexPath.row-1]
            
            cell.setupCell(TitleSectionHeroeCellViewModel(title: data.title))
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsSectionHeroeCell") as? ComicsSectionHeroeCell else { return UITableViewCell() }
            
            let data = viewModel.dataSource[indexPath.section].comics.items[indexPath.row-1]
            let model = ComicsSectionHeroeCellViewModel(title: data.name, date: "")
            cell.setupCell(model)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if viewModel.dataSource[indexPath.section].isOpened {
            
            viewModel.dataSource[indexPath.section].isOpened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            
        } else {
            
            viewModel.dataSource[indexPath.section].isOpened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        
        if let eventHeader = tableView.cellForRow(at: indexPath) as? HeaderSectionEventsCell {
            eventHeader.toggleCollapseIndicator(viewModel.dataSource[indexPath.section].isOpened)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!viewModel.isMoreDataLoading) {
                       
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                viewModel.isMoreDataLoading = true
        
                viewModel.limit += 20
                let from: Int = viewModel.limit < viewModel.totalItems ? viewModel.limit : viewModel.totalItems
                
                viewModel.fetchData(limit: from)
            }
        }
    }
    
}

// EventsViewModelProtocol
extension EventsViewController: EventsViewModelProtocol {
    func showLoader() {
        Utils.showLoader(in: self)
    }
    
    func hideLoader() {
        Utils.hideLoader(in: self)
    }
    
    func showError(_ error: Error) {
        Utils.showToast(in: self, backgroundColor: .errorColor, title: error.localizedDescription)
    }
    
    func finishLoadData() {
        tableView.reloadData()
    }
    
}

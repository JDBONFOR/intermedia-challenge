import UIKit

class SuperheroesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private var viewModel: SuperheroesViewModel = SuperheroesViewModel()
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? Int else { return }
        
        if segue.identifier == "loadHeroe" {
            let heroeVC = segue.destination as! HeroeViewController
            heroeVC.viewModel = HeroeViewModel(id: sender)
        }
    }

}

// MARK: - Private Methods
private extension SuperheroesViewController {
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
                
        viewModel.delegate = self
        
        // Register Cell
        tableView.register(UINib(nibName: "SuperheroesCell", bundle: nil), forCellReuseIdentifier: "SuperheroesCell")
    }
    
    func fetchData() {
        viewModel.fetchData(limit: viewModel.limit)
    }
}

// MARK: - Extensions
// UITableViewDelegate, UITableViewDataSource
extension SuperheroesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuperheroesCell") as! SuperheroesCell
        cell.setupCell(viewModel.dataSource[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "loadHeroe", sender: viewModel.dataSource[indexPath.row].id)
        
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

// SuperheroesViewModelProtocol
extension SuperheroesViewController: SuperheroesViewModelProtocol {
    func showError(_ error: Error) {
        Utils.showToast(in: self, backgroundColor: .errorColor, title: error.localizedDescription)
    }
    
    func finishLoadData() {
        tableView.reloadData()
    }
    
    
}

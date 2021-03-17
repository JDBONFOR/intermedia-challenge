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

}

// MARK: - Private Methods
private extension SuperheroesViewController {
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        self.navigationController?.navigationItem.title = "Prueba"
        
        viewModel.delegate = self
        
        // Register Cell
        tableView.register(UINib(nibName: "SuperheroesCell", bundle: nil), forCellReuseIdentifier: "SuperheroesCell")
    }
    
    func fetchData() {
        viewModel.fetchData()
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
}

// SuperheroesViewModelProtocol
extension SuperheroesViewController: SuperheroesViewModelProtocol {
    func finishLoadData() {
        tableView.reloadData()
    }
}

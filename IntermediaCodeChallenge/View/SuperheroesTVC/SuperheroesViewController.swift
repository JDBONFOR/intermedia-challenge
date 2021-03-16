import UIKit

class SuperheroesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private var heroes: [HeroesModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Register Cell
        tableView.register(UINib(nibName: "SuperheroesCell", bundle: nil), forCellReuseIdentifier: "SuperheroesCell")
        
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
        
        setupNavigationBar()
        
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationItem.title = "Prueba"
    }
    
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
                self.heroes = result.data.results
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Extensions
extension SuperheroesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuperheroesCell") as! SuperheroesCell
        cell.setupCell(heroes[indexPath.row])
        return cell
        
    }
}

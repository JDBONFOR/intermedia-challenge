import UIKit

class SuperheroesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Register Cell
        tableView.register(UINib(nibName: "SuperheroesCell", bundle: nil), forCellReuseIdentifier: "SuperheroesCell")
    }

}

// MARK: - Private Methods
private extension SuperheroesViewController {
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavigationBar()
        
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationItem.title = "Prueba"
    }
    
    func fetchData() {
        
    }
}

// MARK: - Extensions
extension SuperheroesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuperheroesCell") as! SuperheroesCell
        return cell
        
    }
    
    
}

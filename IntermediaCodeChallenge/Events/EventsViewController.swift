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
        tableView.register(UINib(nibName: "EventsCell", bundle: nil), forCellReuseIdentifier: "EventsCell")
        
    }
    
    func fetchData() {
        viewModel.fetchData()
    }
    
}

// MARK: - Extensions
// UITableViewDelegate, UITableViewDataSource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell") as! EventsCell
        cell.setupCell(viewModel.dataSource[indexPath.row])
        return cell
    }
    
}

// EventsViewModelProtocol
extension EventsViewController: EventsViewModelProtocol {
    func finishLoadData() {
        tableView.reloadData()
    }
    
}

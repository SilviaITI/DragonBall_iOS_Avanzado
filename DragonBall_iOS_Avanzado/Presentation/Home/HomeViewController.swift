//
//  HomeViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 15/1/24.
//

import UIKit

// MARK: - Protocol -
protocol HomeViewControllerDelegate {
    var heroesCount: Int { get }
    var viewState: ((HomeViewState) -> Void)? { get set}
    var loginViewModel: LoginViewControllerDelegate { get }
    func logOut()
    func onViewAppear()
    func fecthHeroes() -> Heroes
    func heroBy(index: Int) -> Hero?
}

// MARK: - Enum States -
enum HomeViewState {
    case navigateToDetail
    case reloadData
    case navigateToMap
    case loading(_ isLoading: Bool)
}
// MARK: - Class -
class HomeViewController: UIViewController, UISearchBarDelegate {
   // MARK: - Outlets -
    @IBOutlet weak var searchHero: UISearchBar!
    @IBOutlet weak var tableHeros: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var exitButton: UIButton!
    
    // MARK: - Properties
    var viewModel: HomeViewControllerDelegate?
    //MARK: - Lyfecycle
    
    @IBOutlet weak var Mapa: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Héroes"
       
        tableHeros.delegate = self
        tableHeros.dataSource = self
        searchHero.delegate = self
        tableHeros.register(
            UINib(nibName: "Cell", bundle: nil),
            forCellReuseIdentifier: Cell.identifier
        )
        setObservers()
        viewModel?.onViewAppear()
       
    }
    
    @IBAction func onClickExitButton(_ sender: Any) {
        viewModel?.logOut()
        let login = LoginViewController()
        login.viewModel = self.viewModel?.loginViewModel
        navigationController?.setViewControllers([login], animated: true)
    }
    
  
    @IBAction func onClickMapButton(_ sender: Any) {
        let mapView = MapViewController()
    mapView.viewModel = MapViewModel(apiProvider: ApiProvider(), keyChainProvider: KeyChainProvider(), heroes: viewModel?.fecthHeroes()) as? any MapViewControllerDelegate
   
        navigationController?.pushViewController(mapView, animated: true)
    }
    
    func reloadData() {
        self.tableHeros.reloadData()
    }
    func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .reloadData:
                    self?.reloadData()
                case .navigateToDetail:
                    print("navigating to detail")
               
                case .navigateToMap:
                    print("navegar al mapa")
                case .loading(let isLoading) :
                    self?.loadingView.isHidden = !isLoading
                }
            }
        }
    }
  
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Cell.estimatedHeight
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.heroesCount ?? 1
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath)
                as? Cell else {
            return UITableViewCell()
        }
       if let hero = viewModel?.heroBy(index: indexPath.row) {
            cell.updateData(with: hero)
            
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) { // para presentar la
            if let hero = viewModel?.heroBy(index: indexPath.row) {
                let detailViewController = DetailViewController()
                let detailViewModel = DetailViewModel(apiProvider: ApiProvider(), keyChainProvider: KeyChainProvider(), hero: hero )
                detailViewController.viewModel = detailViewModel
                navigationController?.show(detailViewController, sender: hero)
                tableView.deselectRow(at: indexPath, animated: true)
                
            }
        }
}



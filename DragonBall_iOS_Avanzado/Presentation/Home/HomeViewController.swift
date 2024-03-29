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
class HomeViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var searchHero: UISearchBar!
    @IBOutlet weak var tableHeros: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var Mapa: UIButton!
    
    // MARK: - Properties
    var viewModel: HomeViewControllerDelegate?
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Héroes"
        searchHero.delegate = self
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
    
    // MARK: - Actions -
    @IBAction func onClickExitButton(_ sender: Any) {
        viewModel?.logOut()
        let login = LoginViewController()
        login.viewModel = self.viewModel?.loginViewModel
        navigationController?.setViewControllers([login], animated: true)
    }
    
    @IBAction func onClickMapButton(_ sender: Any) {
        let mapView = MapViewController()
        mapView.viewModel = MapViewModel(apiProvider: ApiProvider(), keyChainProvider: KeyChainProvider(), heroes: viewModel?.fecthHeroes())
        navigationController?.pushViewController(mapView, animated: true)
    }
    
    // MARK: - Functions -
    private func reloadData() {
        self.tableHeros.reloadData()
    }
    
    private func setObservers() {
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

// MARK: - Extension -
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Cell.estimatedHeight
    }
    func numberOfSections(in tableView: UITableView) -> Int {
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let homeViewModel = viewModel as? HomeViewModel else {
            print("Error: viewModel is not HomeViewModel")
            return
        }
        if searchText.isEmpty {
            homeViewModel.heroes = homeViewModel.originalHeroes
        } else {
            homeViewModel.heroes = homeViewModel.originalHeroes.filter { $0.name?.lowercased().contains(
                searchText.lowercased()) ?? false }
        }
        tableHeros.reloadData()
    }
}



    

    
    
    
    
    


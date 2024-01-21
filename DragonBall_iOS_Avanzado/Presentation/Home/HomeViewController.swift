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
    func logOut()
    func onViewAppear()
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
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var exit: UITabBarItem!
    @IBOutlet weak var map: UITabBarItem!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - Properties
    var viewModel: HomeViewControllerDelegate?
    //MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Héroes"
        tabBar.delegate = self
        tableHeros.delegate = self
        tableHeros.dataSource = self
        searchHero.delegate = self
        viewModel?.onViewAppear()
        tableHeros.register(
            UINib(nibName: "Cell", bundle: nil),
            forCellReuseIdentifier: Cell.identifier
        )
        setObservers()
       
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
    
//    func tableView(
//        _ tableView: UITableView,
//        didSelectRowAt indexPath: IndexPath) { // para presentar la
//            let hero = viewModel?.heroBy(index: indexPath.row)
//            let detailViewController = DetailViewController()
//            detailViewController.hero = hero
//            navigationController?.show(detailViewController, sender: nil)
//            tableView.deselectRow(at: indexPath, animated: true)
//            
//            
//        }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == exit {
            viewModel?.logOut()
            let login = LoginViewController()
            navigationController?.setViewControllers([login], animated: true)
            
            //CoreDataManager.shared.deleteAll()
        } else if item == map{
            print("pulsado")
            //    let mapViewController = MapViewController()
            //    mapViewController.heroes = viewModel.heroes
            //    navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
}


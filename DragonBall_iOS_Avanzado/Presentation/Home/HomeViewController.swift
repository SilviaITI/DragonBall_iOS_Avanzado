//
//  HomeViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 15/1/24.
//

import UIKit

// MARK: - Protocol -
protocol HomeViewControllerDelegate {
    func  fetchHeroesList()
    var viewState: ((HomeViewState) -> Void)? { get set}
}

enum HomeViewState {
    case navigateToDetail
    case reloadData
}

class HomeViewController: UIViewController {

    @IBOutlet weak var searchHero: UISearchBar!
    @IBOutlet weak var tableHeros: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    var viewModel: HomeViewControllerDelegate?
    //MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  HomeViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//

import UIKit
protocol HeroesViewControllerDelegate {
    var viewState: ((HeroesViewState) -> Void)? {get set}
}
enum HeroesViewState {
    case loading(_ isLoading: Bool)
    case navigateToDetail
}
class HeroesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
  
    var viewModel: HeroesViewControllerDelegate?
    
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

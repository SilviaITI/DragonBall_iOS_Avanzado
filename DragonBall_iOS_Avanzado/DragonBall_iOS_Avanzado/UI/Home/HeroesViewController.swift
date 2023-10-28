//
//  HeroesViewController.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 27/10/23.
//

import UIKit
protocol HeroesViewControllerDelegate {
  
}
class HeroesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let apiProvider = ApiProvider()
    private let  keyChainProvider = KeyChainProvider()
    var heroes: Heroes = []
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
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
    func updateData() {
        guard let token = self.keyChainProvider.getToken() else { return }
        apiProvider.getHeroes(by: nil, token: token) { heroes in
            self.heroes = heroes
        }
        
    }
    
}
extension HeroesViewController: UITableViewDelegate, UITableViewDataSource {
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
        }

       
      

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                           for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
          let hero = heroes[indexPath.row]
                cell.updateCell(
                          name: hero.name,
                          photo: hero.photo,
                          description: hero.description
                      )
                 

            return cell

            }

        }

//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            performSegue(withIdentifier: "HEROES_TO_HERO_DETAIL",
//                         sender: indexPath.row)
//        }
    
    
    


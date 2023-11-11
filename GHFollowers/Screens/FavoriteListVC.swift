//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-10.
//

import UIKit

class FavoriteListVC: GFDataLoadingVC {
    
    let tableView = UITableView()
    var favorites = [Follower]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTabelView()
    }
    
    private func configureTabelView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    private func configureVC(){
        view.backgroundColor = .systemBackground
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getFavorites(){
        PersistenceManager.retrieveFavourites {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }            }
        }
    }
    
    private func updateUI(with favorites:[Follower]){
        if favorites.isEmpty{
            showEmptyStateMessage(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
        }else{
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}

extension FavoriteListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{
            return
        }
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else{
                favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unabale to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
}

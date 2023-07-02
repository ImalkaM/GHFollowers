//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-15.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var userName:String!
    var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCollectionView()
        getFollowers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        
        //calculate available width for a single object
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumItemSpacing:CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        
        
        return flowLayout
    }
    
    private func configureVC(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    private func getFollowers(){
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result{
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
}

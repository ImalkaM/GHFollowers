//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-15.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    
    enum Section{
        case main
    }
    
    var username:String!
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section,Follower>!
    
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    init(username:String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
         view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    private func configureVC(){
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        view.backgroundColor = .systemBackground
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func getFollowers(username:String, page: Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        
        //no matter what will exceute before fucntion exist
        defer{
            dismissLoadingView()
            isLoadingMoreFollowers = false
        }
        Task{
            do{
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                
            }catch{
                if let gfError = error as? GFErrorMessage{
                    self.presentGFAlert(title: "Bad stuff happend", message: gfError.rawValue, buttonTitle: "ok")
                }else{
                    presentDefaultGFAlert()
                }
                self.isLoadingMoreFollowers = false
                dismissLoadingView()
            }
            
        }
    //Mark: another way to write if we want to show a generic error
//        Task{
//            guard let followers = try? await NetworkManager.shared.getFollowers(for: username, page: page)else{
//                self.isLoadingMoreFollowers = false
//                dismissLoadingView()
//                presentDefaultGFAlert()
//                return
//            }
//            updateUI(with: followers)
//            self.isLoadingMoreFollowers = false
//            dismissLoadingView()
//        }
       
        //old way
//        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//            guard let self = self else{return}
//            self.dismissLoadingView()
//            switch result{
//            case .success(let followers):
//                updateUI(with: followers)
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "ok")
//            }
//            self.isLoadingMoreFollowers = false
//        }
    }
    
    private func updateUI(with followers:[Follower]){
        if followers.count < 100 {self.hasMoreFollowers = false}
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty{
            let message = "This user doesen't have any followers, Go follow Them.😀"
            
            DispatchQueue.main.async {
                self.showEmptyStateMessage(with: message, in: self.view)
                return
            }
        }
        self.updateData(on: self.followers)
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers:[Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
    }
    
    @objc func addButtonTapped(){
        showLoadingView()
        Task{
            do{
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                self.dismissLoadingView()
            }catch{
                if let error = error as? GFErrorMessage{
                    DispatchQueue.main.async {
                        self.presentGFAlert(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
                    }
                }else{
                    presentDefaultGFAlert()
                }
            }
        }
//        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
//            guard let self = self else{return}
//            self.dismissLoadingView()
//            switch result{
//            case .success(let user):
//                addUserToFavorites(user: user)
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
//            }
//        }
    }
    
    
    private func addUserToFavorites(user: User){
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
            guard let self else{return}
            guard let error else {
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Success", message: "You have successfully favorited the user!", buttonTitle: "Hooray!!")
                }
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
     
        //pagination, retreive more followers.
        if offsetY > contentHeight - height{
            guard hasMoreFollowers, !isLoadingMoreFollowers else{return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //choose active array
        let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
    }
}


extension FollowerListVC:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
}


extension FollowerListVC:UserInfoVCDelegate{
    func didRequestFollowers(for username: String) {
        self.username = username
        self.title = username
        page = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}

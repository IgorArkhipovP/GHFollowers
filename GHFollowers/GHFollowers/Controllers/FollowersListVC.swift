//
//  FolowersListVC.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 12.03.2022.
//

import UIKit

protocol FollwerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowersListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var username: String!
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    
    private var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFollowersListVC()
        configureFollowerListVCCollectionView()
        getFollowers(username: username, page: page)
        configureSearchController()
        filteredFollowers = followers
        collectionView?.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureFollowersListVC(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
        imageViewOfLoadingIcon()
        
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissImageViewOfLoadingIcon()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersitenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentAlertControllerOnMainThread(title: "Success!", messageBody: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    
                    self.presentAlertControllerOnMainThread(title: "Something went wrong", messageBody: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentAlertControllerOnMainThread(title: "Something went wrong", messageBody: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else {return UICollectionViewCell()}
        let follower = followers[indexPath.row]
        cell.set(follower: follower)
        return cell
    }
        
    func configureFollowerListVCCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.3
        layout.minimumInteritemSpacing = 0.3
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4,
                                 height: (view.frame.size.width/3)-4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        // configureDataSource()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        // searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username: String, page: Int){
        imageViewOfLoadingIcon()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissImageViewOfLoadingIcon()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.filteredFollowers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user does not have any followers."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view)}
                }
                
                DispatchQueue.main.async { self.collectionView?.reloadData() }
            case .failure(let error):
                self.presentAlertControllerOnMainThread(title: "Bad things happen", messageBody: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? followers : filteredFollowers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}
    
extension FollowersListVC: UISearchBarDelegate {

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            var tempData: [Follower] = self.filteredFollowers
            
            if searchText.isEmpty {
                self.followers = self.filteredFollowers
            } else {
                isSearching = true
                tempData = self.filteredFollowers.filter{
                    ($0.login).localizedCaseInsensitiveContains(searchText)
                }
                self.followers = tempData
                self.collectionView?.reloadData()
            }
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.followers = self.filteredFollowers
        self.collectionView?.reloadData()
    }
}

extension FollowersListVC: FollwerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        getFollowers(username: username, page: page)
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView?.setContentOffset(.zero, animated: true)
    }
}
    //MARK: Sean's approach
//func configureDataSource(){
//    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider:  (collectionView, indexPath, follower) -> UICollectionViewCell? in
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! ollowerCell
//        cell.set(follower: follower)
//        return cell
//    })
//}

//    func updateData(){
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(followers)
//        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
//    }
    //        Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
    //                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
    //                cell.set(follower: follower)
    //                return cell
    //
    //    }
        
        
    //   func configureCollectionView(){
    //       collectionView = UICollectionView(frame: .init(x: 100, y: 100, width: 100, height: 100), collectionViewLayout: layout)
    //       view.addSubview(collectionView)
    //       layout.scrollDirection = .vertical
    //       collectionView.setCollectionViewLayout(layout, animated: true)
    //       collectionView.backgroundColor = .systemBackground
    //       collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    //   }
        
    //    func createThreeColumnsFlowLayour() -> UICollectionViewFlowLayout {
    //        let width                       = view.bounds.width
    //        let padding: CGFloat            = 0.3
    //        let minimumItemSpacing: CGFloat = 0.5
    //        let availableWidth              = width - (padding * 0.8) - (minimumItemSpacing * 0.8)
    //        let itemWidth                   = availableWidth / 3
    //
    //        let flowLayout                  = UICollectionViewFlowLayout()
    //        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: -padding, bottom: -padding, right: padding)
    //        flowLayout.itemSize             = CGSize(width: 0.5, height: 0.3)
    //
    //        return flowLayout
    //    }

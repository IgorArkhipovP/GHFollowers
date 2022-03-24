//
//  FolowersListVC.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 12.03.2022.
//

import UIKit

class FollowersListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var followers: [Follower] = []
    var username: String!
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFollowersListVC()
        configureFollowerListVCCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureFollowersListVC(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell else {return UICollectionViewCell()}
        cell.set(follower: followers[indexPath.item])
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
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.followers = followers
                DispatchQueue.main.async { self.collectionView?.reloadData() }
            case .failure(let error):
                self.presentAlertControllerOnMainThread(title: "Bad things happen", messageBody: error.rawValue, buttonTitle: "Ok")
            }
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
}

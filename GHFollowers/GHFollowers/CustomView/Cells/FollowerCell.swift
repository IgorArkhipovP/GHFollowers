//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 21.03.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    // let follower: Follower
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
//    private var myImageView: UIImageView {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "avatar-placeholder")
//        return imageView
//    }
    
//    private var myLabel: UILabel {
//        let label = UILabel()
//        label.text = follower.login
//        return label
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.clipsToBounds = true
        // configureFollowerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set (follower: Follower){
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        usernameLabel.frame = CGRect(x: 5,
                                     y: contentView.frame.size.height-40,
                                     width: contentView.frame.size.width-1,
                                     height: 50)
        
        avatarImageView.frame = CGRect(x: 5,
                                     y: 0,
                                     width: contentView.frame.size.width-1,
                                   height: contentView.frame.size.height-30)
    }
  
    //MARK: Sean's approach
    // func configureFollowerCell(){
        // addSubview(avatarImageView)
        // addSubview(usernameLabel)
        
        // let paddling: CGFloat = 8
        
//        NSLayoutConstraint.activate([
//            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddling),
//            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddling),
//            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddling),
//            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
//
//            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
//            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddling),
//            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddling),
//            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
//        ])
//    }
    
// }


}

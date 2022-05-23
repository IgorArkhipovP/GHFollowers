//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 30.03.2022.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.setConfigurationOfButton(color: .systemGreen, titleLabel: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }

}

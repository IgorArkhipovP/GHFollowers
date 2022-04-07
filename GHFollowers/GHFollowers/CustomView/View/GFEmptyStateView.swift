//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 27.03.2022.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let GFEmptyTitleTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let GFEmptyTitleImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configreGFEmptyStateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        GFEmptyTitleTitleLabel.text = message
        configreGFEmptyStateView()
    }
    
    
    
    private func configreGFEmptyStateView() {
        addSubview(GFEmptyTitleTitleLabel)
        addSubview(GFEmptyTitleImage)
        
        GFEmptyTitleTitleLabel.numberOfLines  = 3
        GFEmptyTitleTitleLabel.textColor      = .secondaryLabel
        
        GFEmptyTitleImage.image         = UIImage(named: "empty-state-logo")
        GFEmptyTitleImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           GFEmptyTitleTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            GFEmptyTitleTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            GFEmptyTitleTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            GFEmptyTitleTitleLabel.heightAnchor.constraint(equalToConstant: 200),
            
           GFEmptyTitleImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            GFEmptyTitleImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            GFEmptyTitleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            GFEmptyTitleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}

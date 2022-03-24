//
//  GBTitleLabel.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 13.03.2022.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGFTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configureGFTitleLabel()
    }
    
    private func configureGFTitleLabel() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

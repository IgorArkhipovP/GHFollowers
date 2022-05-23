//
//  GFButton.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 09.03.2022.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String) {
        self.init(frame: .zero)
        setConfigurationOfButton(color: color, titleLabel: title)
    }
    
    private func configureButton(){
        translatesAutoresizingMaskIntoConstraints = false
        
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        
        //MARK: New button style in iOS15
//        layer.cornerRadius = 10
//        setTitleColor(.white, for: .normal)
//        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    final func setConfigurationOfButton(color: UIColor, titleLabel: String) {
        
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = titleLabel
        
//    self.backgroundColor = backgroundColor
//    setTitle(titleLabel, for: .normal)
    }
}

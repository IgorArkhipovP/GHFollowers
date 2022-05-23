//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 09.03.2022.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 10
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        //MARK: A format of keyboard keyboardType = .decimalPad
        returnKeyType = .go
        placeholder = "Enter a username"
        
    }
}

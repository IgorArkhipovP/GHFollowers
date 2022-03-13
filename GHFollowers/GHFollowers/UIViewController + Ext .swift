//
//  UIViewController + Ext .swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 13.03.2022.
//

import UIKit

extension UIViewController {
    
    func presentAlertControllerOnMainThread(title: String, messageBody: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: messageBody, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
}

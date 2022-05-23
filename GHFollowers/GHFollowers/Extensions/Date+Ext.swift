//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 30.03.2022.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
    
}

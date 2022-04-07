//
//  CollectionView+Iterration.swift
//  GHFollowers
//
//  Created by Игорь  Архипов on 04.04.2022.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

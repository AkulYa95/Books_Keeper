//
//  TableViewCellViewModelType.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

protocol TableViewCellViewModelType {
    var bookName: String {get}
    var date: String {get}
    var indexPath: IndexPath {get}
}

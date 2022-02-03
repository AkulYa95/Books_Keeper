//
//  BuildBookViewModelType.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

protocol BuildBookViewModelType {
    
    var bookName: String? {get}
    var date: Date {get}
    var title: String {get}
    var buttonTitle: String {get}
    var maxDate: Date? {get}
    
}

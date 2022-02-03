//
//  AddBookViewModel.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

class AddBookViewModel: BuildBookViewModelType {
    
    var bookName: String? {
        return nil
    }
    
    var date: Date {
        return Date()
    }
    
    var title: String {
        return "Add new book"
    }
    
    var buttonTitle: String {
        return "Add"
    }
    
    var maxDate: Date? {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .month, value: 3, to: Date())
        return date
    }
    
    
    
}

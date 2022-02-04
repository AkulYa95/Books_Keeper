//
//  EditBookViewModel.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation
import RealmSwift

class EditBookViewModel: BuildBookViewModelType {
    
    private var books: Results<Book>
    
    private var indexPath: IndexPath
    
    var book: Book {
        
        return books[indexPath.row]
    }
    
    var bookName: String? {
        return book.name
    }
    
    var date: Date {
        
        
        book.returnDate
    }
    
    var title: String {
        return "Edit info"
    }
    
    var buttonTitle: String {
        "Edit"
    }
    
    var maxDate: Date? {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .month, value: 3, to: Date())
        return date
    }
    
    init (books: Results<Book>, indexPath: IndexPath) {
        self.books = books
        self.indexPath = indexPath
    }
    
}

//
//  TableViewCellViewModel.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    
    var bookName: String {
        return book.name
    }
    
    var returnDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: book.returnDate)
    }
    
    private var book: Book
    
    init(book: Book) {
        self.book = book
    }
}

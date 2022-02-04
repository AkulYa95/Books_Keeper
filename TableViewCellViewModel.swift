//
//  TableViewCellViewModel.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    
    private var book: Book
    
    var indexPath: IndexPath
        
    var bookName: String {
        return book.name
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
                
        return dateFormatter.string(from: book.returnDate)
    }


    
    init(book: Book, indexPath: IndexPath) {
        self.book = book
        self.indexPath = indexPath
    }
}

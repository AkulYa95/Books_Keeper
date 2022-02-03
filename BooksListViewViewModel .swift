//
//  BooksListViewViewModel.swift
//  
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation
import RealmSwift

class BooksListViewViewModel: BooksListViewModelType {

    var books: Results<Book>!
        
    var numberOfRows: Int {
        return books.count
    }
    
    private var selectedIndexPath: IndexPath?
    
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let book = books[indexPath.row]
        return TableViewCellViewModel(book: book)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func viewModelToAdd() -> BuildBookViewModelType? {
        return AddBookViewModel()
    }
    
    func viewModeltoEditRow() -> BuildBookViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }

        return EditBookViewModel(books: books, indexPath: selectedIndexPath)
    }
    
    func sortBooksByName() {
        books = books.sorted(byKeyPath: "name")
    }
    
    func sortBooksByDate() {
        books = books.sorted(byKeyPath: "returnDate")
    }
    
}

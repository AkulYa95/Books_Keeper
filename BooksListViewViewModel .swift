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
    
    var actualBooks: Results<Book>!
    
    var outdatedBooks: Results<Book>!
    
    private var selectedIndexPath: IndexPath?
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        
        var book: Book
        
        if indexPath.section == 0 {
            book = actualBooks[indexPath.row]
        } else {
            book = outdatedBooks[indexPath.row]
        }
        return TableViewCellViewModel(book: book, indexPath: indexPath)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func viewModelToAdd() -> BuildBookViewModelType? {
        return AddBookViewModel()
    }
    
    func viewModeltoEditRow() -> BuildBookViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        var filteredBooks: Results<Book>!
        if selectedIndexPath.section == 0 {
            filteredBooks = actualBooks
        } else {
            filteredBooks = outdatedBooks
        }
        
        return EditBookViewModel(books: filteredBooks, indexPath: selectedIndexPath)
    }
    
    func sortBooksByName() {
        actualBooks = actualBooks.sorted(byKeyPath: "name")
        outdatedBooks = outdatedBooks.sorted(byKeyPath: "name")
    }
    
    func sortBooksByDate() {
        actualBooks = actualBooks.sorted(byKeyPath: "returnDate")
        outdatedBooks = outdatedBooks.sorted(byKeyPath: "returnDate")
    }
    
    func filteringBooks() {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = TimeZone.current
        
        let string = dateFormatter.string(from: Date())
        let date = dateFormatter.date(from: string)
        
        guard let date = date else { return }
        
        actualBooks = books.where {
            $0.returnDate >= date
        }
        
        outdatedBooks = books.where {
            $0.returnDate < date
        }
    }
    
    func numberOfRowsIn(Section section: Int) -> Int {
        switch section {
        case 0:
            return actualBooks.count
        case 1:
            return outdatedBooks.count
        default:
            return 0
        }
    }
    
    func headerFor(Section section: Int) -> String {
        switch section {
        case 0:
            return "Actual books"
        case 1:
            return "Outdate books"
        default:
            return "No data"
        }
    }
    
    func deleteBook(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            StorageManager.deleteBook(actualBooks[indexPath.row])
        } else {
            StorageManager.deleteBook(outdatedBooks[indexPath.row])
        }
    }
}

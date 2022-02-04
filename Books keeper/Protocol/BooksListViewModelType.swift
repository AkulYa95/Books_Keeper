//
//  BooksListViewModelType.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

protocol BooksListViewModelType {
    
    func numberOfRowsIn(Section section: Int) -> Int
        
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func selectRow(atIndexPath indexPath: IndexPath)
    
    func viewModelToAdd() -> BuildBookViewModelType?
    
    func viewModeltoEditRow() -> BuildBookViewModelType?
    
    func sortBooksByName()
    
    func sortBooksByDate()
    
    func filteringBooks()
    
    func headerFor(Section section: Int) -> String
    
    func deleteBook(at indexPath: IndexPath)
    
}

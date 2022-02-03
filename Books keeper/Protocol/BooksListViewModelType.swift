//
//  BooksListViewModelType.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 31.01.2022.
//

import Foundation

protocol BooksListViewModelType {
    
    var numberOfRows: Int {get}
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func selectRow(atIndexPath indexPath: IndexPath)
    
    func viewModelToAdd() -> BuildBookViewModelType?
    
    func viewModeltoEditRow() -> BuildBookViewModelType?
    
    func sortBooksByName()
    
    func sortBooksByDate()
    
}

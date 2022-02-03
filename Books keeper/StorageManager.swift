//
//  StorageManager.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 30.01.2022.
//

import RealmSwift


class StorageManager {

    static let realm = try! Realm()
    
    static func saveBook(_ book: Book) {
        try! realm.write({
            realm.add(book)
        })
    }
    
    static func deleteBook(_ book: Book) {
        try! realm.write({
            realm.delete(book)
        })
    }
    
    static func editList(_ book: Book, _ eddedBook:Book) {
        try! realm.write({
            book.name = eddedBook.name
            book.returnDate = eddedBook.returnDate
        })
    }
}

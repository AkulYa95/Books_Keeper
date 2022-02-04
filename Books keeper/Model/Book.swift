//
//  Book.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 29.01.2022.
//

import RealmSwift
import Foundation


class Book: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var returnDate = Date()
        
}

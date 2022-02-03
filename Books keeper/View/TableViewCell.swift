//
//  TableViewCell.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 29.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var returnDateLabel: UILabel!
    
    var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            bookNameLabel.text = viewModel.bookName
            returnDateLabel.text = viewModel.returnDate
            
        }
    }
}

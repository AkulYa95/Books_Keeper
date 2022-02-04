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
            returnDateLabel.text = viewModel.date
            if viewModel.indexPath.section == 1 {
                returnDateLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            } else {
                returnDateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            }
            
        }
    }
}

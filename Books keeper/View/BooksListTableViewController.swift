//
//  BooksListTableViewController.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 29.01.2022.
//

import UIKit
import RealmSwift

class BooksListTableViewController: UITableViewController {
    
    @IBOutlet var emptyListView: UIView!
    
    var viewModel: BooksListViewViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BooksListViewViewModel()
        guard let viewModel = viewModel else { return }
        viewModel.books = StorageManager.realm.objects(Book.self)
        viewModel.filteringBooks()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        tableView.reloadData()
    }
    
    @IBAction func addButton() {
        performSegue(withIdentifier: SegueIdentifier.add.rawValue, sender: nil)
    }
    
    @IBAction func sortButton() {
        sortAlert()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
    }
    
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.headerFor(Section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsIn(Section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        guard let tableViewCell = cell,
              let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        performSegue(withIdentifier: SegueIdentifier.edit.rawValue, sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if editingStyle == .delete {
            viewModel.deleteBook(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateUI()
        }
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
              let viewModel = viewModel,
              let destinationVC = segue.destination as? BuildBookViewController else
              { return }
        
        switch identifier {
        case SegueIdentifier.add.rawValue:
            destinationVC.viewModel = viewModel.viewModelToAdd()
            
        case SegueIdentifier.edit.rawValue:
            destinationVC.viewModel = viewModel.viewModeltoEditRow()
            
        default: break
        }
    }
}

extension BooksListTableViewController {
    func updateUI() {
        guard let viewModel = viewModel else { return }
        if viewModel.books.count == 0 {
            tableView.backgroundView = emptyListView
        } else {
            tableView.backgroundView = .none
        }
    }
}

extension BooksListTableViewController {
    func sortAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sortByNameAction = UIAlertAction(title: "Sort by name", style: .default) { _ in
            self.viewModel?.sortBooksByName()
            self.tableView.reloadData()
        }
        let sortByDateAction = UIAlertAction(title: "Sort by date", style: .default) { _ in
            self.viewModel?.sortBooksByDate()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(sortByNameAction)
        alert.addAction(sortByDateAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}

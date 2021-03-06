//
//  BuildBookViewController.swift
//  Books keeper
//
//  Created by Ярослав Акулов on 29.01.2022.
//

import UIKit

class BuildBookViewController: UIViewController {
    
    @IBOutlet var buildTF: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let buildButton = UIButton()
    private var buttonCoordinate: CGFloat!
    
    var viewModel: BuildBookViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton(with: view.frame.size)
        updateUI()
        buildTF.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        createButton(with: size)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func buildButtonPressed() {
        
        guard let viewModel = viewModel else { return }
        guard let bookName = buildTF.text, !bookName.isEmpty else {return}
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = .current
        
        let datePickerDate = datePicker.date
        
        let string = dateFormatter.string(from: datePickerDate)
        let date = dateFormatter.date(from: string)
    
        guard let date = date else { return }
        
        let book = Book()
        book.name = bookName
        book.returnDate = date
        DispatchQueue.main.async {
            if let _ = viewModel as? AddBookViewModel {
                StorageManager.saveBook(book)
            } else if let viewModel = viewModel as? EditBookViewModel {
                StorageManager.editList(viewModel.book, book)
            }
        self.performSegue(withIdentifier: SegueIdentifier.unwindSegueToBooksList.rawValue, sender: nil)
        }
    }
}

// MARK: - Create and update UI elements

extension BuildBookViewController {
    
    func createButton(with viewSize: CGSize) {
        
        let viewHeight = viewSize.height
        let viewWidth = viewSize.width
        
        let leftConstraint = CGFloat(36)
        let rightConstraint = viewWidth - 36
        
        let width = rightConstraint - leftConstraint
        let height = CGFloat(50)
        
        let topConstraint = viewHeight - height - 59
        buildButton.frame = CGRect(x: leftConstraint,
                                   y: topConstraint ,
                                   width: width,
                                   height: height)
        
        buildButton.layer.cornerRadius = 10
        buildButton.setTitleColor(buildButton.titleColor(for: .normal)?.withAlphaComponent(0.5), for: .highlighted)
        
        buildButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        buildButton.layer.shadowOpacity = 0.5
        buildButton.layer.shadowRadius = 5
        
        buildButton.addTarget(self, action: #selector(buildButtonPressed), for: .touchUpInside)
        self.view.addSubview(buildButton)
        
        buttonCoordinate = buildButton.frame.origin.y
    }
    
    func updateUI() {
        
        guard let viewModel = viewModel else { return }
        
        title = viewModel.title
        buildTF.placeholder = "Book name"
        buildTF.text = viewModel.bookName
        buildButton.setTitle(viewModel.buttonTitle, for: .normal)
        
        datePicker.minimumDate = Date()
        datePicker.maximumDate = viewModel.maxDate
        datePicker.date = viewModel.date
        
        updateButton()
    }
    
    func updateButton() {
        
        let unenabledColor = UIColor(red: 201/255,
                                     green: 201/255,
                                     blue: 204/255,
                                     alpha: 1)
        
        let enabledColor = UIColor(red: 7/255,
                                   green: 123/255,
                                   blue: 249/255,
                                   alpha: 1)
        
        if buildTF.text?.isEmpty == true {
            
            buildButton.isEnabled = false
        } else {
            
            buildButton.isEnabled = true
        }
        
        buildButton.backgroundColor = buildButton.isEnabled ? enabledColor : unenabledColor
        
        
        
    }
}

extension BuildBookViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.buildButton.frame.origin.y == buttonCoordinate {
            self.buildButton.frame.origin.y = buttonCoordinate - keyboardSize.height + 34
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.buildButton.frame.origin.y != buttonCoordinate {
            self.buildButton.frame.origin.y = buttonCoordinate
        }
    }
}

extension BuildBookViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " " {
            return false
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buildButtonPressed()
        return true
    }
    
    func transitionUpdate() {
        
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        
        let leftConstraint = CGFloat(36)
        let rightConstraint = viewWidth - 36
        
        let width = rightConstraint - leftConstraint
        let height = CGFloat(50)
        
        let topConstraint = viewHeight - height - 59
        
        buildButton.frame = CGRect(x: leftConstraint,
                                   y: topConstraint ,
                                   width: width,
                                   height: height)
        

    }
}

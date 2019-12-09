//
//  ViewController.swift
//  TODOListStackView
//
//  Created by Kira on 20.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let elementRadius = CGFloat(5)
    let borderWidth = CGFloat(2)
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var notesList: NoteListView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setup()
    }
    
    private func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setup() {
        
        addButton.layer.cornerRadius = CGFloat(elementRadius)
        textView.layer.borderWidth = borderWidth
        textView.layer.cornerRadius = elementRadius
        
        addObservers()
        self.hideKeyboardWhenTappedAround()
        fillNotesList()
    }
    
    @objc func updateTextView(notification: Notification) {
        
        guard
            let userInfo = notification.userInfo as? [String: Any],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
    
            mainScrollView.contentOffset = CGPoint.zero
        } else {
            
            mainScrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
        }
    }
    
    private func fillNotesList () {
        
        let list = Notes(messages: exampleMessages)
        
        self.notesList.addNotes(notes: list)
    }

    @IBAction func addNote(_ sender: Any) {
        
        guard textView.text != nil else { return }
        
        notesList.addNoteWith(message: textView.text)
        textView.text = ""
        textView.resignFirstResponder()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


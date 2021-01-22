//
//  DetailViewController.swift
//  assessmentEvents
//
//  Created by Chris Withers on 1/22/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var statusLabel: UILabel!
    
    var event: Event? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let currentTitle = titleTextField.text, !currentTitle.isEmpty else { showMessage(status: false); return }
        if let currentEvent = event {
            EventController.shared.updateEvent(event: currentEvent, title: currentTitle, date: datePicker.date)
        } else {
            EventController.shared.addEvent(title: currentTitle, date: datePicker.date)
        }
        showMessage(status: true)
    }
    
    func showMessage(status: Bool) {
        
        let alertController = UIAlertController(title: status ? "Saved" : "Attention", message: status ? "Event saved!" : "Please add a title", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: status ? "Awesome!" : "Ok" , style: .default) { (UIAlertAction) in
            if status {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
        
    func updateViews(){
        guard let currentEvent = event else { return }
        guard let date = currentEvent.date else { return }
        statusLabel.text = "Editing..."
        titleTextField.text = event?.title
        datePicker.date = date
    }
}


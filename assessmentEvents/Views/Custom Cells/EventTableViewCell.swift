//
//  EventTableViewCell.swift
//  assessmentEvents
//
//  Created by Chris Withers on 1/22/21.
//

import UIKit

protocol didTapIsGoingDelegate: AnyObject {
    func changeIsGoingStatus(sender: EventTableViewCell, event: Event)
}

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var isGoingButton: UIButton!
    
    var event: Event?
    
    weak var delegate: didTapIsGoingDelegate?
    
    @IBAction func isGoingButtonTapped(_ sender: UIButton) {
        guard let currentEvent = event else { return }
        delegate?.changeIsGoingStatus(sender: self, event: currentEvent)
    }
    
    func updateViews(event: Event){
        eventTitleLabel.text = event.title
        isGoingButton.setImage(event.isGoing ? UIImage(systemName: "clock.fill") : UIImage(systemName: "clock"), for: .normal)
    }
}

//
//  EventListTableViewController.swift
//  assessmentEvents
//
//  Created by Chris Withers on 1/22/21.
//

import UIKit

class EventListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        EventController.shared.setUpSections()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return EventController.shared.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Attending" : "Not Attending"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EventController.shared.sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        let currentEvent = EventController.shared.sections[indexPath.section][indexPath.row]
        cell.delegate = self
        cell.event = currentEvent
        cell.updateViews(event: currentEvent)

        return cell
    }
    


    
     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let eventToDelete = EventController.shared.sections[indexPath.section][indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            EventController.shared.setUpSections()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEvent" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? DetailViewController else { return }
            let eventClicked = EventController.shared.sections[indexPath.section][indexPath.row]
            destination.event = eventClicked
        }
    }
}

extension EventListTableViewController: didTapIsGoingDelegate {
    func changeIsGoingStatus(sender: EventTableViewCell, event: Event) {
        EventController.shared.toggleIsGoing(event: event)
        sender.updateViews(event: event)
        EventController.shared.setUpSections()
        tableView.reloadData()
    }
}

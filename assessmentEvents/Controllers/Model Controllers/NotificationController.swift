//
//  NotificationController.swift
//  assessmentEvents
//
//  Created by Chris Withers on 1/22/21.
//

import Foundation
import UserNotifications

protocol EventSchedulerDelegate: AnyObject {
    func scheduleUserNotifications(for event: Event)
    func cancelUserNotifications(for event: Event)
}

extension EventSchedulerDelegate {
    func scheduleUserNotifications(for event: Event){
        
        let content = UNMutableNotificationContent()
        guard let id = event.id else {return}
        content.title = "REMINDER"
        content.body = "\(event.title ?? "Calender Alert!")"
        content.sound = .default
        
        guard let date = event.date else {return}
        
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (Error) in
            if let error = Error {
                print("Unable to add noticiation request \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func cancelUserNotifications(for event: Event) {
        guard let id = event.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}

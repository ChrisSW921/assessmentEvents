//
//  EventController.swift
//  assessmentEvents
//
//  Created by Chris Withers on 1/22/21.
//

import CoreData

class EventController {
    
    static var shared = EventController()
    
    var events: [Event] {
        let fetchRequest: NSFetchRequest<Event> = {
             let request = NSFetchRequest<Event>(entityName: "Event")
             request.predicate = NSPredicate(value: true)
             return request
         }()
         return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    var isGoingEvents: [Event] = []
    var isNotGoingEvents: [Event] = []
    var sections: [[Event]] { [isGoingEvents, isNotGoingEvents] }
    
    func setUpSections(){
        isGoingEvents.removeAll()
        isNotGoingEvents.removeAll()
        for event in events{
            if event.isGoing {
                isGoingEvents.append(event)
            }else{
                isNotGoingEvents.append(event)
            }
        }
    }
    
    func addEvent(title: String, date: Date) {
        let newEvent = Event(title: title, date: date)
        scheduleUserNotifications(for: newEvent)
        CoreDataStack.saveContext()
    }
    
    func updateEvent(event: Event, title: String, date: Date) {
        event.title = title
        event.date = date
        if event.isGoing {
            cancelUserNotifications(for: event)
            scheduleUserNotifications(for: event)
        } else {
            cancelUserNotifications(for: event)
        }
        CoreDataStack.saveContext()
    }
    
    func toggleIsGoing(event: Event) {
        event.isGoing.toggle()
        if event.isGoing {
            cancelUserNotifications(for: event)
            scheduleUserNotifications(for: event)
        } else {
            cancelUserNotifications(for: event)
        }
        CoreDataStack.saveContext()
    }
    
    func deleteEvent(event: Event){
        cancelUserNotifications(for: event)
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
    
}
extension EventController: EventSchedulerDelegate{
    
}

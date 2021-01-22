//
//  Event+Convenience.swift
//  assessmentEvents
//
//  Created by Chris Withers on 1/22/21.
//

import CoreData

extension Event {
    @discardableResult convenience init(title: String, isGoing: Bool = true, date: Date, id: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.isGoing = isGoing
        self.date = date
        self.id = id
    }
}

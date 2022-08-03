//
//  ClassroomApp.swift
//  Classroom
//
//  Created by Stefania Zinno for the Developer Academy on 12/01/22.
//

import SwiftUI

@main
struct ClassroomApp: App {
    let persistenceManager = PersistenceManager.shared
    
    var body: some Scene {
        WindowGroup {
            LearnerList()
                .environment(\.managedObjectContext, persistenceManager.container.viewContext)
        }
    }
}

//
//  TaskApp.swift
//  Task
//
//  Created by Sahitya on 11/08/24.
//

import SwiftUI

@main
struct TaskApp: App {
    let coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.context)
        }
    }
}

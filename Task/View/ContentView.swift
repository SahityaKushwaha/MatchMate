//
//  ContentView.swift
//  Task
//
//  Created by Sahitya on 11/08/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        ProfileMatchesView()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataStack.shared.context)
}

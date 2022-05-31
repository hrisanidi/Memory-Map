//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

@main
struct MemoryMapApp: App {
    //Initializing data controller
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            //Setting up view hierarchy with navigation view
            NavigationView {
                ContentView()
            }
            //Passing the data container into the environment
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .accentColor(.black)
            .navigationViewStyle(.stack)
        }
    }
}

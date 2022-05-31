//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//Main screen view
struct ContentView: View {
    @State var firstButtonText = "Memories"
    @State var firstButtonImage = "heart"
    
    @State var secondButtonText = "Map"
    @State var secondButtonImage = "globe.europe.africa"
    
    var body: some View {
        VStack {
            NavigationLink(destination: LocationListView()){
                OverviewButtonConfig(text: $firstButtonText, image: $firstButtonImage)
            }
            
            NavigationLink(destination: MapView()){
                OverviewButtonConfig(text: $secondButtonText, image: $secondButtonImage)
            }
            
            Spacer()
            Spacer()
        }
        .navigationTitle("Overview")
    }
}



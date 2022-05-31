//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI
import Foundation

//Layout of our location profile
struct LocationProfileView: View {
    //Setting up environment and loading persistent data
    @Environment(\.managedObjectContext) var managedObjContext
    @ObservedObject var location: FetchedResults<LocationProfile>.Element
    
    @State private var editingProfile = false
    
    var body: some View {
        ScrollView {
            ImageModel().returnProfileImage(image: location.picture)
                .padding()
            
            Text(location.review!)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .padding()
        .navigationBarTitle(location.name!, displayMode: .inline)
        //Logic for editing button
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "pencil.circle")
                    .onTapGesture {
                        editingProfile.toggle()
                    }
                    .sheet(isPresented: $editingProfile) {
                        EditLocationView(location: location)
                    }
            }
        }
    }
}





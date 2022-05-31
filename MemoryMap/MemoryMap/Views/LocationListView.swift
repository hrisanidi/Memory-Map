//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

struct LocationListView: View {
    //Setting up environment and loading persistent data
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var locations: FetchedResults<LocationProfile>
    
    @State var searchText = ""
    @State var searchingLocation = false
    @State var showFavoritesOnly = false
    
    var body: some View {
        //Search design
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText)
                        .disableAutocorrection(true)
                        .onTapGesture {
                            searchingLocation = true
                        }
                }
                .foregroundColor(.gray)
                .padding()
            }
            .frame(height: 40)
            .cornerRadius(15)
            .padding()
            
            //List layout and simple search logic
            List {
                ForEach(locations) { location in
                    if location.name!.hasPrefix(searchText) || searchText == "" {
                        NavigationLink(destination: LocationProfileView(location: location)){
                            HStack{
                                ImageModel().returnImage(image: location.picture)
                                Text(location.name!)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                }
                .onDelete(perform: deleteLocation)
            }
            .navigationBarTitle("Memories", displayMode: .inline)
            .listStyle(.plain)
            //EditButton for deleting from list
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    //Deleting from CoreData(triggered by onDelete)
    private func deleteLocation(offsets: IndexSet) {
        withAnimation {
            offsets.map { locations[$0] }
            .forEach(managedObjContext.delete)
            
            // Saves to our database
            DataController.shared.save(context: managedObjContext)
        }
    }
}






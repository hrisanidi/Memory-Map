//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI
import MapKit

struct MapView: View {
    //Setting up environment and loading persistent data
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<LocationProfile>
    
    //Initializing the map model
    @StateObject private var mapModel = MapModel()
    
    @State private var text = ""
    @State var searchingLocation = false
    @State private var addingLocation = false
    @State private var searchSheetActive = false
    
    @State private var searchButtonImage = "magnifyingglass"
    @State private var addButtonImage = "star"
    
    var body: some View {
        ZStack {
            //Displaying the map and user annotations(their coordinates are stored in CoreData)
            //Click on annotation leads to the location profile
            Map(coordinateRegion: $mapModel.position, annotationItems: locations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    NavigationLink(destination: LocationProfileView(location: location)){
                        LocationMarkConfig()
                    }
                }
            }
            .ignoresSafeArea()
            
            //Marker that points to the center of the map
            CenterPointMarkConfig()
            
            VStack {
                Spacer()
    
                HStack {
                    Spacer()
                    //Button for adding the annotation that triggers the appropriate sheet
                    MapButtonConfig(image: $addButtonImage)
                        .onTapGesture {
                            addingLocation.toggle()
                        }.sheet(isPresented: $addingLocation) {
                            AddLocationView(latitude: $mapModel.position.center.latitude, longitude: $mapModel.position.center.longitude)
                        }
                }
                
                //Block for implementing search
                HStack {
                    Spacer()
                    //Search button that triggers a sheet
                    MapButtonConfig(image: $searchButtonImage)
                        .onTapGesture {
                            searchSheetActive.toggle()
                        }.sheet(isPresented: $searchSheetActive) {
                            //Search design
                            VStack(spacing: 0) {
                                ZStack {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                        TextField("Search for a place", text: $text)
                                            .disableAutocorrection(true)
                                            .onTapGesture {
                                                searchingLocation = true
                                            }
                                            .onSubmit {
                                                mapModel.getLocation(address: text)
                                            }
                                    }
                                    .foregroundColor(.gray)
                                    .padding()
                                }
                                .frame(height: 40)
                                .cornerRadius(15)
                                .padding()
                                
                                //Showing results
                                if searchingLocation == true && text != "" {
                                    List {
                                        ForEach(mapModel.addresses?.data ?? [], id: \.self) { address in
                                            Text(address.label ?? "")
                                                .onTapGesture {
                                                    searchSheetActive = false
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                                        //Setting a map to a chosen location
                                                        mapModel.setLocation(latitude: address.latitude, longitude: address.longitude)
                                                    }
                                                }
                                        }
                                    }
                                    .listStyle(.plain)
                                }
                                
                                Spacer()
                            }
                        }
                }
            }
        }
    }
}


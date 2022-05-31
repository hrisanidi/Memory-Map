//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

struct AddLocationView: View {
    //Setting up environment and loading persistent data
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var review = "Write a few thoughts.."
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    @Binding var latitude : Double
    @Binding var longitude : Double
    
    //Adding location annotation
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Name", text: $name)
                        .disableAutocorrection(true)
                }
                
                Section() {
                    TextEditor(text: $review)
                        .disableAutocorrection(true)
                }
                
                //Adding image
                Section() {
                    VStack(alignment: .center) {
                        Image(uiImage: self.image)
                            .locationImageAppearance()
                            .padding()
                        
                        Divider()
                        
                        PhotoLibButtonConfig()
                            .onTapGesture {
                                isShowPhotoLibrary = true
                            }
                            .padding()
                        
                    }
                    .padding()
                    .sheet(isPresented: $isShowPhotoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, pickedImage: self.$image)
                    }
                }
                
                //Saving to the CoreData
                Section() {
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController.shared.addLocation(
                                name: name,
                                image: image,
                                review: review,
                                latitude: latitude,
                                longitude: longitude,
                                context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
                .disabled(name.isEmpty)
            }.navigationBarTitle(Text("Add a memory"))
        }
    }
}




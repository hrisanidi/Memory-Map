//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

struct EditLocationView: View {
    //Setting up environment and loading persistent data
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    //Observing the state of location, so the editing changes are displayed instantly
    @ObservedObject var location: FetchedResults<LocationProfile>.Element
    
    @State private var name = ""
    @State private var review = ""
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    //Editing location annotation
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Name", text: $name)
                        .disableAutocorrection(true)
                }
                .onAppear{
                    name = location.name!
                    review = location.review!
                    image = unwrapImage(image: location.picture)
                }
                
                Section() {
                    TextEditor(text: $review)
                        .disableAutocorrection(true)
                }
                
                //Displaying the current user photo and the logic for changing it
                Section() {
                    
                    VStack(alignment: .center) {
                        Image(uiImage: image)
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
                
                //Saving changes
                Section() {
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController.shared.editLocation(location: location,
                                                               name: name,
                                                               image: image,
                                                               review: review,
                                                               context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
                .disabled(name.isEmpty)
            }.navigationBarTitle(Text("Editing mode"))
        }
    }
    
    //Function converting binary data into the UIImage
    func unwrapImage(image: Data?) -> UIImage {
        let defaultImage = UIImage()
        guard let unwrapped = image else {
            return defaultImage
        }
        return UIImage(data: unwrapped)!
    }
}




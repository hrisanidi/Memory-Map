//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//Set of functions for converting binary data from CoreData into the image that is needed
struct ImageModel {
    func returnImage(image: Data?) -> some View {
        if let displayedImage = image {
            return AnyView(Image(uiImage: UIImage(data: displayedImage)!)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/))
        } else {
            return AnyView(BlankImageConfig())
        }
    }
    
    func returnProfileImage(image: Data?) -> some View {
        if let displayedImage = image {
            return AnyView(Image(uiImage: UIImage(data: displayedImage)!)
                            .resizable()
                            .frame(width: 270, height: 270)
                            .clipShape(Circle()))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func returnEditImage(image: Data?) -> some View {
        if let displayedImage = image {
            return AnyView(Image(uiImage: UIImage(data: displayedImage)!)
                            .resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 200, height: 200, alignment: .center))
        } else {
            return AnyView(EmptyView())
        }
    }
}

//Function to apply modifiers to UIImage
extension Image {
    func locationImageAppearance() -> some View {
        self
            .resizable()
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .frame(width: 200, height: 200, alignment: .center)
    }
}


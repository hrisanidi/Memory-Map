//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//View is presented if the user hasn't provided an image
struct BlankImageConfig: View {
    var body: some View {
        ZStack{
            Image(systemName: "camera")
                .foregroundColor(.gray)
        }
        .frame(width: 60, height: 60)
    }
}

//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//View for the center point of the map
struct CenterPointMarkConfig: View {
    var body: some View {
        Image(systemName: "star")
            .resizable()
            .foregroundColor(.black)
            .opacity(0.95)
            .frame(width: 25, height: 25, alignment: .center)
    }
}

struct CenterPointMarkConfig_Previews: PreviewProvider {
    static var previews: some View {
        CenterPointMarkConfig()
    }
}

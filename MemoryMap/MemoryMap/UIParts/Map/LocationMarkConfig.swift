//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//View for marking chosen locations
struct LocationMarkConfig: View {
    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .foregroundColor(.yellow)
            .frame(width: 25, height: 25)
    }
}

struct LocationMarkConfig_Previews: PreviewProvider {
    static var previews: some View {
        LocationMarkConfig()
    }
}


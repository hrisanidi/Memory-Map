//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//View is used for main butttons on a map
struct MapButtonConfig: View {
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    static let gradientStart = Color(red: 255.0 / 255, green: 102.0 / 255, blue: 102.0 / 255)
    
    @Binding var image : String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.linearGradient(
                    Gradient(colors: [Self.gradientEnd, Self.gradientStart]),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .opacity(0.70)
            
            Image(systemName: image)
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .opacity(0.85)
        }
        .frame(width: 60, height: 60)
        .padding()
    }
}



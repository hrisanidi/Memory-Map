//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//Button for invoking photo library
struct PhotoLibButtonConfig: View {
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    static let gradientStart = Color(red: 255.0 / 255, green: 102.0 / 255, blue: 102.0 / 255)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.linearGradient(
                    Gradient(colors: [Self.gradientEnd, Self.gradientStart]),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(maxWidth: .infinity, maxHeight: 70.0)
                .opacity(0.85)
            
            HStack {
                Image(systemName: "photo.circle")
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
                
                Text("Photo library")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, maxHeight: 70.0)
            .padding()
        }
        
        
        
        
    }
}

struct PhotoLibButtonConfig_Previews: PreviewProvider {
    static var previews: some View {
        PhotoLibButtonConfig()
    }
}

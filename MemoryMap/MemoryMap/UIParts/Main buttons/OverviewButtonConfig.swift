//Created by Vladislav Khrisanov (xkhris00)

import SwiftUI

//Button design for the main menu
struct OverviewButtonConfig: View {
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    static let gradientStart = Color(red: 255.0 / 255, green: 102.0 / 255, blue: 102.0 / 255)
    
    @Binding var text : String
    @Binding var image : String
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 25)
                .fill(.linearGradient(
                    Gradient(colors: [Self.gradientEnd, Self.gradientStart]),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(maxWidth: .infinity, maxHeight: 100.0)
                .padding()
                .opacity(0.70)
            
            HStack() {
                Text(text).font(.largeTitle).bold()
                    .foregroundColor(.black)
                    .padding([.top, .bottom, .leading], 20.0)
                    .opacity(0.85)
                
                Spacer()
                
                Image(systemName: image)
                    .resizable()
                    .frame(width: 70.0, height: 70.0)
                    .padding([.top, .bottom, .trailing], 20.0)
                    .foregroundColor(.black)
                    .opacity(0.75)
            }
            .frame(maxWidth: .infinity, maxHeight: 100.0)
            .padding()
        }
    }
}



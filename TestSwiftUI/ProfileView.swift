//
//  ProfileView.swift
//  TestSwiftUI
//
//  Created by Sergey Shcheglov on 25.04.2022.
//

import SwiftUI

struct ProfileView: View {
    @State private var backgroundImage = Image("horizontal-background")
    @State private var profileImage = Image("mcconaughey")
    @State private var sampleText = "Describe yourself..."
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Profile picture")
                    
                    Spacer()
                    
                    Button("Edit") {
                        
                    }
                }
                
                ZStack {
                    profileImage
                        .resizable()
//                        .scaledToFit()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 150, height: 150, alignment: .center)
                }
                
                
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Cover photo")
                    
                    Spacer()
                    
                    Button("Edit") {
                        
                    }
                }
                backgroundImage
                    .resizable()
                    .scaledToFit()
                    
                
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Bio")
                    Spacer()
                    
                    Button("Edit") {
                        
                    }
                }
                
                TextField("Add text to your bio", text: $sampleText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
//                    .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
            }
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

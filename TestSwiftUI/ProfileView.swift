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
    @State private var sampleText = ""
    
    @State private var inputProfileImage: UIImage?
    @State private var inputBackgroundImage: UIImage?

    
    @State private var showingImagePicker = false
    @State private var showingBackgroundImagePicker = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Profile picture")
                    
                    Spacer()
                    
                    Button("Edit") {
                        showingImagePicker = true
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
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputProfileImage)
                }
                .onChange(of: inputProfileImage) { _ in loadProfileImage() }
                
                
            }

            
            Divider()
            
            VStack {
                HStack {
                    Text("Cover photo")
                    
                    Spacer()
                    
                    Button("Edit") {
                        showingBackgroundImagePicker = true
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
                
                TextField("Describe yourself...", text: $sampleText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .frame(maxHeight: .infinity, alignment: .center)
                
                Divider()
            }
        }
        .padding()
        .sheet(isPresented: $showingBackgroundImagePicker) {
            ImagePicker(image: $inputBackgroundImage)
        }
        .onChange(of: inputBackgroundImage) { _ in loadBackgroundImage() }
        
    }
    
    func loadBackgroundImage() {
        guard let inputBackgroundImage = inputBackgroundImage else {
            return
        }
        backgroundImage = Image(uiImage: inputBackgroundImage)
    }
    
    func loadProfileImage() {
        guard let inputProfileImage = inputProfileImage else {
            return
        }
        profileImage = Image(uiImage: inputProfileImage)
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

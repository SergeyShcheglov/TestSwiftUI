//
//  ProfileView.swift
//  TestSwiftUI
//
//  Created by Sergey Shcheglov on 25.04.2022.
//

import SwiftUI

struct ProfileView: View {
    @State private var backgroundImage = Image("horizontal-background")
    @State private var profileImage: Image = Image("mcconaughey")
    
    private var bioEmpty = "Describe yourself..."
    @State private var bioDescription = ""
    @State private var bioInEditMode = false
    @FocusState private var isBioFocused: Bool
    
    @State private var inputProfileImage: UIImage?
    @State private var inputBackgroundImage: UIImage?

    
    @State private var showingImagePicker = false
    @State private var showingBackgroundImagePicker = false
    
    let savePaths = FileManager.documentDirectory
    let filename = FileManager.documentDirectory.appendingPathComponent("bio.txt")



    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Profile picture")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Button("Edit") {
                        showingImagePicker = true
                    }
                }
                
                    profileImage
                        .resizable()
//                        .scaledToFit()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 150, height: 150, alignment: .center)
                        .padding(.bottom)
                        .onAppear {
                            getProfilePhotoFrom()
                        }
                        
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputProfileImage)
            }
            .onChange(of: inputProfileImage) { _ in loadProfileImage() }

            
            Divider()
            
            VStack {
                HStack {
                    Text("Cover photo")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Button("Edit") {
                        showingBackgroundImagePicker = true
                    }
                }
                backgroundImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(.bottom)
                    .onAppear {
                        getBackgroundPhotoFrom()
                    }
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Bio")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button {
                        self.bioInEditMode.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                self.isBioFocused = true
                        }
                        
                        do {
                            try bioDescription.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                            print("saved string")
                        } catch {
                            print(error)
                        }
                    } label: {
                        Text(bioInEditMode ? "Save" : "Edit")
                    }
                }
                Group {
                    if bioInEditMode {
                        TextField(bioEmpty, text: $bioDescription).font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .focused($isBioFocused)
                    } else {
                        Text(bioDescription == "" ? bioEmpty : bioDescription)
                    }
                }
                .foregroundColor(.secondary)
                .font(.system(size: 20))
                .frame(height: 20)
                
                Divider()
            }
        }
        .padding()
        .sheet(isPresented: $showingBackgroundImagePicker) {
            ImagePicker(image: $inputBackgroundImage)
        }
        .onChange(of: inputBackgroundImage) { _ in loadBackgroundImage() }
        .onAppear {
            guard let data = try? Data(contentsOf: filename) else {
                return
            }
            
            guard let str = String(data: data, encoding: String.Encoding.utf8) else {
                return
            }
            bioDescription = str
            
        }
        
    }
    func saveBio() {
        do {
            try bioDescription.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            print("saved string")
        } catch {
            print(error)
        }
    }
    func loadBackgroundImage() {
        guard let inputBackgroundImage = inputBackgroundImage else {
            return
        }
        backgroundImage = Image(uiImage: inputBackgroundImage)
        saveBackgroundImage()
    }
    
    func loadProfileImage() {
        guard let inputProfileImage = inputProfileImage else {
            return
        }
        profileImage = Image(uiImage: inputProfileImage)
        saveProfileImage()
    }
    
    func saveProfileImage() {
            if let jpegData = inputProfileImage?.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: savePaths.appendingPathComponent("Profile image"), options: [.atomic, .completeFileProtection])
                print("Saved profile")
            } else {
                print("Couldn't save Profile Image to docs")
            }
    }
    
    func saveBackgroundImage() {
            if let jpegData = inputBackgroundImage?.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: savePaths.appendingPathComponent("Background image"), options: [.atomic, .completeFileProtection])
                print("Saved background")
            } else {
                print("Couldn't save Background Image to docs")
            }
    }
    
    func getProfilePhotoFrom() -> Image {
        guard let data = try? Data(contentsOf: savePaths.appendingPathComponent("Profile image")) else {
            return Image("mcconaughey")
        }
        guard let uiImage = UIImage(data: data, scale: 1.0) else {
            return Image("mcconaughey")
        }
        profileImage = Image(uiImage: uiImage)
        return profileImage
    }
    
    func getBackgroundPhotoFrom() -> Image {
        print("ok")
        guard let data = try? Data(contentsOf: savePaths.appendingPathComponent("Background image")) else {
            return Image("horizontal-background")
        }
        print("ok2")
        guard let uiImage = UIImage(data: data, scale: 1.0) else {
            return Image("horizontal-background")
        }
        print("ok 3")
        backgroundImage = Image(uiImage: uiImage)
        print("ok 4")
        return backgroundImage
    }
    
//    func getPhoto(image: Image) -> Image {
//        let component = String(image)
//        guard let data = try? Data(contentsOf: savePaths.appendingPathComponent(image)) else {
//            return Image("mcconaughey")
//        }
//        guard let uiImage = UIImage(data: data, scale: 1.0) else {
//            return Image("mcconaughey")
//        }
//        return Image(uiImage: uiImage)
//    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

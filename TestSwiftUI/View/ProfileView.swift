//
//  ProfileView.swift
//  TestSwiftUI
//
//  Created by Sergey Shcheglov on 25.04.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ViewModel()
    @FocusState private var isBioFocused: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            //MARK: - Profile picture
            VStack {
                HStack {
                    Text("Profile picture")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button("Edit") {
                        vm.showingImagePicker = true
                    }
                }
                
                vm.profileImage
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding(.bottom)
            }
            .sheet(isPresented: $vm.showingImagePicker) { ImagePicker(image: $vm.inputProfileImage) }
            .onChange(of: vm.inputProfileImage) { _ in vm.loadProfileImage() }
            
            Divider()
            
            //MARK: - Cover Photo
            VStack {
                HStack {
                    Text("Cover photo")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Button("Edit") {
                        vm.showingBackgroundImagePicker = true
                    }
                }
                vm.backgroundImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(.bottom)
            }
            .sheet(isPresented: $vm.showingBackgroundImagePicker) { ImagePicker(image: $vm.inputBackgroundImage)}
            .onChange(of: vm.inputBackgroundImage) { _ in vm.loadBackgroundImage() }
            
            Divider()
            
            //MARK: - Bio
            VStack {
                HStack {
                    Text("Bio")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button {
                        vm.bioInEditMode.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            self.isBioFocused = true
                        }
                        vm.saveBio()
                    } label: {
                        Text(vm.bioInEditMode ? "Save" : "Edit")
                    }
                }
                Group {
                    if vm.bioInEditMode {
                        TextField(vm.bioEmpty, text: $vm.bioDescription).font(.system(size: 20))
                            .multilineTextAlignment(.center)
                            .focused($isBioFocused)
                    } else {
                        Text(vm.bioDescription == "" ? vm.bioEmpty : vm.bioDescription)
                    }
                }
                .foregroundColor(.secondary)
                .font(.system(size: 20))
                .frame(height: 20)
                
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

//
//  ViewModel.swift
//  TestSwiftUI
//
//  Created by Sergey Shcheglov on 26.04.2022.
//

import SwiftUI

@MainActor class ViewModel: ObservableObject {
    @Published var backgroundImage = Image("horizontal-background")
    @Published var profileImage = Image("mcconaughey")
    
    @Published var bioEmpty = "Describe yourself..."
    @Published var bioDescription = ""
    @Published var bioInEditMode = false
    
    @Published  var inputProfileImage: UIImage?
    @Published  var inputBackgroundImage: UIImage?
    
    @Published  var showingImagePicker = false
    @Published  var showingBackgroundImagePicker = false
    
    var savePaths = FileManager.documentDirectory
    let filenameProfilePhoto = "Profile photo"
    let filenameBackgroundPhoto = "background photo"
    let filenameBio = "bio.txt"
    
        
    init() {
        bioDescription = getBio()
        backgroundImage = getImageFrom(fileName: filenameBackgroundPhoto) ?? Image("horizontal-background")
        profileImage = getImageFrom(fileName: filenameProfilePhoto) ?? Image("mcconaughey")
    }
    
    func saveBio() {
        do {
            try bioDescription.write(to: savePaths.appendingPathComponent(filenameBio), atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Error saving bio: \(error.localizedDescription)")
        }
    }
    
    func getBio() -> String {
        guard let data = try? Data(contentsOf: savePaths.appendingPathComponent(filenameBio)) else {
            return ""
        }
        
        guard let str = String(data: data, encoding: String.Encoding.utf8) else {
            return ""
        }
        bioDescription = str
        return bioDescription
    }
    func loadBackgroundImage() {
        guard let inputBackgroundImage = inputBackgroundImage else {
            return
        }
        backgroundImage = Image(uiImage: inputBackgroundImage)
        saveImage(fileName: filenameBackgroundPhoto, image: inputBackgroundImage)
    }
    
    func loadProfileImage() {
        guard let inputProfileImage = inputProfileImage else {
            return
        }
        profileImage = Image(uiImage: inputProfileImage)
        saveImage(fileName: filenameProfilePhoto, image: inputProfileImage)
    }
    
    func saveImage(fileName: String, image: UIImage) {
        let image = image
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePaths.appendingPathComponent(fileName), options: [.atomic, .completeFileProtection])
            print("saved image")
        } else {
            print("Couldn't save image")
        }
    }
    
    func getImageFrom(fileName: String) -> Image? {
        guard let data = try? Data(contentsOf: savePaths.appendingPathComponent(fileName)) else {
            return nil
        }
        guard let uiImage = UIImage(data: data, scale: 1.0) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}

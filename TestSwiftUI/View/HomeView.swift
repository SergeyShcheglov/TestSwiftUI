//
//  HomeView.swift
//  TestSwiftUI
//
//  Created by Sergey Shcheglov on 25.04.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = ViewModel()
    private var name = "John Doe"
    private var postText = "If you're looking for a cute dessert for a party or even just a little pick-me up, try making some of @bakedbyjosie's bite sized cheesecakes! For more delicious baked goods, watch Baked by Josie"
    
    var body: some View {
        ScrollView {
            
            //MARK: - Header
            VStack {
                vm.backgroundImage
                    .resizable()
                    .scaledToFit()
                
                vm.profileImage
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 180, height: 180, alignment: .center)
                    .overlay(Circle().stroke(Color.white, lineWidth: 15))
                    .offset(y: -90)
                    .padding(.bottom, -90)
            }
            
            //MARK: - Name & Bio
            VStack(alignment: .center) {
                Text(name)
                    .font(.title)
                    .frame(maxWidth: .infinity)
                Text(vm.bioDescription)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
            }
            
            Divider()
        
            //MARK: - POSTS
            Text("Posts")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ForEach(0..<2) { _ in
                VStack {
                    HStack {
                        vm.profileImage
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                        
                        Text(name)
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                        
                        Spacer()
                    }
                    VStack {
                        Text(postText)
                        Image("horizontal-background")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            vm.bioDescription = vm.getBio()
            vm.backgroundImage = vm.getImageFrom(fileName: vm.filenameBackgroundPhoto)
            vm.profileImage = vm.getImageFrom(fileName: vm.filenameProfilePhoto)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

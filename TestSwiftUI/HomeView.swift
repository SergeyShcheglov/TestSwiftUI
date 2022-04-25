//
//  HomeView.swift
//  TestSwiftUI
//
//  Created by Sergey Shcheglov on 25.04.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var backgroundImage = Image("horizontal-background")
    @State private var profileImage = Image("mcconaughey")
    
    @State private var name = "John Doe"
    @State private var bio = "This is bio"
    
    @State private var postText = "If you're looking for a cute dessert for a party or even just a little pick-me up, try making some of @bakedbyjosie's bite sized cheesecakes! For more delicious baked goods, watch Baked by Josie"
    
    var body: some View {
        ScrollView {
            VStack {
                backgroundImage
                    .resizable()
                    .scaledToFit()
                
                profileImage
                    .resizable()
                    .clipShape(Circle())
                    .scaledToFill()
                    .frame(width: 180, height: 180, alignment: .center)
                    .overlay(Circle().stroke(Color.white, lineWidth: 15))
                    .offset(y: -90)
                    .padding(.bottom, -90)
            }
            
            
            VStack(alignment: .center) {
                Text(name)
                    .font(.title)
                    .frame(maxWidth: .infinity)
                Text(bio)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
            }
            
            
            Divider()
            
            Text("Posts")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                HStack {
                    profileImage
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 40, height: 40, alignment: .leading)
                    
                    VStack {
                        Text(name)
                        
                        Spacer()
                    }
                    Spacer()
                }
                
                Text(postText)
                
                profileImage
                    .resizable()
                    .scaledToFit()
            }
            .padding()
            
            VStack {
                HStack {
                    profileImage
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 40, height: 40, alignment: .leading)
                    
                    Text(name)
                    Spacer()
                }
                
                Text(postText)
                
                profileImage
                    .resizable()
                    .scaledToFit()
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

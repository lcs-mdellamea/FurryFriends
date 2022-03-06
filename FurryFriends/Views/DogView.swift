//
//  DogView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

struct DogView: View {
    
    // MARK: Stored properties
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    // MARK: Computed properties
    
    
    var body: some View {
        
        VStack {
            
            Divider()
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage)
                .frame(width: 250, height: 170, alignment: .center)
                .border(.black, width: 2)
                .padding()
            
            HStack {
            
                Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                
            }
                
            Divider()
            
            HStack {
                
                Text("Library:")
                    .font(.title)
                    .padding()
                
                Spacer()
                
            }
            
            Divider()
            
//            List {
//
//                NavigationLink(destination: SavedDogs()) {
//                    Text("Dogs")
//                }
//
//            }
            
            .padding()
            
            // Push main image to top of screen
            Spacer()
            
        }
        // Runs once when the app is opened
        .task {
            
            // Example images for each type of pet
       //     let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
            let remoteDogImage = "https://images.dog.ceo/breeds/labrador/lab_young.JPG"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            currentImage = URL(string: remoteDogImage)!
                        
        }
        .navigationTitle("Furry Friends")
        
    }
    
    // MARK: Functions
    
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            DogView()
            
        }
    }
}

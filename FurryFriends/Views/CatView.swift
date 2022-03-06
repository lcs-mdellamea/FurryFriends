//
//  CatView.swift
//  FurryFriends
//
//  Created by Madison Dellamea on 3/2/22.
//

import SwiftUI

struct CatView: View {
    
    // MARK: Stored properties
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    // This will let us know whether the current exists as a favorite
    @State var favorites: [CatPicture] = []   // empty list to start
    
    @State var currentCatAddedToFavorites: Bool = false
    
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
//                NavigationLink(destination: SavedCats()) {
//                    Text("Cats")
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
            let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
//            let remoteDogImage = "https://images.dog.ceo/breeds/labrador/lab_young.JPG"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            currentImage = URL(string: remoteCatImage)!
                        
        }
        .navigationTitle("Furry Friends")
        
    }
    
    // MARK: Functions
    
    func loadNewCatPicture() async {
        
    }
    
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            CatView()
            
        }
    }
}

//
//  CatsOrDogsView.swift
//  FurryFriends
//
//  Created by Madison Dellamea on 3/2/22.
//

import SwiftUI

struct CatsOrDogsView: View {
    
    //MARK: Stored Properties:
    
    @State var firstImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    @State var secondImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    var body: some View {
        
        VStack(alignment:.center, spacing: 15) {
            
            Divider()
            .padding()
            
            Spacer()
            
            Text("Would you like to see cats or dogs?")
                .underline()
                .font(.title2)
            
            Text("(This can be changed later.)")
                .font(.title2)
                .padding()
            
            HStack {
                
                RemoteImageView(fromURL: firstImage)
                    .border(.black, width: 2)
                    .padding()
                
                RemoteImageView(fromURL: secondImage)
                    .border(.black, width: 2)
                    .padding()
                
            }
            .padding()
            
            HStack(spacing: 15) {
                
                // Stylized navigationlink that leads to CatView.
                NavigationLink(destination: CatView(), label: {
                    
                    Text("Cats")
                        .font(.title2)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(red: 211 / 255,
                                                       green: 211 / 255,
                                                       blue: 211 / 255)))
                    
                })
                
                //                Button(action: {
                //                    print("Floating Button Click")
                //                }, label: {
                //                    NavigationLink(destination: ContentView()) {
                //                        Text("cats")
                //                            .font(.title2)
                //                            .foregroundColor(.black)
                //                    }
                //                })
                //                    .buttonStyle(.bordered)
                
                Text("or")
                    .font(.title2)
                
                //                Button(action: {
                //                    print("Floating Button Click")
                //                }, label: {
                //                    NavigationLink(destination: DogView()) {
                //                        Text("dogs")
                //                            .font(.title2)
                //                            .foregroundColor(.black)
                //                    }
                //                })
                //                    .buttonStyle(.bordered)
                
                // Stylized navigationlink that leads to ContentView.
                NavigationLink(destination: DogView(), label: {
                    
                    Text("Dogs")
                        .font(.title2)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(red: 211 / 255,
                                                       green: 211 / 255,
                                                       blue: 211 / 255)))
                    
                })
                
            }
            
            Spacer()
            
            Divider()
                .padding()
            
            Spacer()
            
        }
        
        .task {
            
            // Example images for each type of pet
            let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
            let remoteDogImage = "https://images.dog.ceo/breeds/labrador/lab_young.JPG"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            firstImage = URL(string: remoteCatImage)!
            secondImage = URL(string: remoteDogImage)!
            
        }
        
        .navigationTitle("FurryFriends")
        
    }
}

struct CatsOrDogsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            CatsOrDogsView()
            
        }
    }
}

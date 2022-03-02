//
//  CatsOrDogsView.swift
//  FurryFriends
//
//  Created by Madison Dellamea on 3/2/22.
//

import SwiftUI

struct CatsOrDogsView: View {
    
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    var body: some View {
        
        VStack {
            
            Divider()
                .padding()
            
            Text("Would you like to see cats or dogs?")
                .underline()
                .font(.title2)
            
            Text("(This can be changed later.)")
            
            
            Spacer()
            
            HStack {
                
                RemoteImageView(fromURL: currentImage)
                    .padding()
                
                RemoteImageView(fromURL: currentImage)
                    .padding()
                
            }
            
            Spacer()
            
            HStack(spacing: 15) {
                
                NavigationLink(destination: ContentView(), label: {
                    
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
                
                NavigationLink(destination: CatView(), label: {
                    
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



// NavigationLink: property buttonstyle
// .buttonStyle(ButtonStyle3D(background: Color.yellow))

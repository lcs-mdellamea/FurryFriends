//
//  FurryFriendsApp.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

@main

struct FurryFriendsApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            TabView {
                
                NavigationView {
                    CatsOrDogsView()
                }
                
                CatsOrDogsView()
                    .tabItem {
                        Image("HouseIcon")
                    }
                
                DogView()
                    .tabItem {
                        Image("DogIcon")
                    }
                CatView()
                    .tabItem {
                        Image("CatIcon")
                    }
                ScoreboardView()
                    .tabItem {
                        Image("ScoreIcon")
                    }
            }
        }
    }
}

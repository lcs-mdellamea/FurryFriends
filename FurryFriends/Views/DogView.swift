//
//  DogView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

struct DogView: View {
    
    // MARK: Stored properties
    
    @Environment(\.scenePhase) var scenePhase
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    
    @State var currentImage: DogPicture = DogPicture(message: URL(string: "https://images.dog.ceo/breeds/mountain-swiss/n02107574_2066.jpg")!,
                                                     status: "success")
    
    @State var favorites: [DogPicture] = []
    
    @State var points: Points = Points(dogs: 0, cats: 0)
    
    @State var currentDogAddedToFavorites = false
    
    // MARK: Computed properties
    
    var body: some View {
        
        
        // Static interface
        
        VStack {
            
            Divider()
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage.message)
                .frame(width: 250, height: 170, alignment: .center)
                .border(.black, width: 2)
                .padding()
            
            HStack {
                
                Image(systemName: "heart.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                //                      CONDITION                        true   false
                    .foregroundColor(currentDogAddedToFavorites == true ? .red : .secondary)
                    .onTapGesture {
                        
                        // Only add to the list if it is not already there
                        if currentDogAddedToFavorites == false {
                            
                            // Adds the current joke to the list
                            favorites.append(currentImage)
                            
                            // Record that we have marked this as a favorite
                            currentDogAddedToFavorites = true
                            
                            points.dogs += 5
                            
                        }
                        
                    }
                
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        
                        syncDownloadNewDogImage()
                        
                        points.dogs += 1
                        
                    }
                
            }
            
            Divider()
            
            HStack {
                
                Text("Library:")
                    .font(.title)
                    .padding()
                
                Spacer()
                
            }
            
            Divider()
            
            ScrollView {
                
                List(favorites, id: \.self) { currentFavorite in
                    Text(currentFavorite.message.absoluteString)
                    
                }
                
            }
            
            // Push main image to top of screen
            Spacer()
            
        }
        
        // Runs once when the app is opened
        
        .task {
            
            // "await" = Will not move on until complete | Downloads data in the background.
            await downloadNewDogImage()
            
            print("I tried to load a new image.")
            
            // Load favorites from the file saved on the device
            loadFavorites()
            loadPoints()
            
        }
        // React to changes of state for the app. (foreground, background, and inactive state.)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active {
                print("Active")
            } else if newPhase == .background {
                print("Background")
                
                //Permanently save the list of favorites.
                persistFavorites()
                persistPoints()
            }
            
        }
        
        .navigationTitle("Furry Friends")
        .padding()
        
    }
    
    // MARK: Functions
    
    func downloadNewDogImage() async {
        
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        
        
        // Example images for each type of pet
        
        //     let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
        
        //  let remoteDogImage = "https://images.dog.ceo/breeds/labrador/lab_young.JPG"
        
        // Replaces the transparent pixel image with an actual image of an animal
        // Adjust according to your preference ☺️
        // Try to fetch a new image
        // It might not work, so we use a do-catch block
        
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentJoke"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentImage = try JSONDecoder().decode(DogPicture.self, from: data)
            
            currentDogAddedToFavorites = false
            
        } catch {
            
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
            
        }
    }
    
    func syncDownloadNewDogImage() {
        
        Task {
            
            await downloadNewDogImage()
            
        }
        
    }
    
    //Save the data permanently
    
    func persistFavorites() {
        
        // Get a location under which to save the data
        let filename = getDocumentsDirectory().appendingPathComponent(savedFavoritesLabel)
        print(filename)
        
        do {
            // Create a JSON Encoder object
            let encoder = JSONEncoder()
            
            // Configure the encoder to "pretty print" the JSON
            encoder.outputFormatting = .prettyPrinted
            
            // Encode the list of favorites we've collected
            let data = try encoder.encode(favorites)
            
            // Write the JSON to a file in the filename earlier
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Saved data to the Documents directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            print("Unable to write list of favorites to the Documents directory")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
    // loads the datat that was saved to the device
    // Loading our favorites:
    func loadFavorites() {
        
        // Get a location under which to save the data
        let filename = getDocumentsDirectory().appendingPathComponent(savedFavoritesLabel)
        print(filename)
        
        //Attempt to load the data
        do {
            // Load raw data
            let data = try Data(contentsOf: filename)
            
            // Write the JSON to a file in the filename earlier
            print("Loaded data from the Documents directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
            // Decode the JSON into Swift native data structures
            // NOTE: we used [DadJoke] since we are loading into a list (array)
            favorites = try JSONDecoder().decode([DogPicture].self, from: data)
            
        } catch {
            // What went wrong
            print("Could not load the data from the stores JSON file.")
            print("=========")
            print(error.localizedDescription)
            
        }
    }
    
    func persistPoints() {
        
        // Get a location under which to save the data
        let filename = getDocumentsDirectory().appendingPathComponent(pointsLabel)
        print(filename)
        
        do {
            // Create a JSON Encoder object
            let encoder = JSONEncoder()
            
            // Configure the encoder to "pretty print" the JSON
            encoder.outputFormatting = .prettyPrinted
            
            // Encode the list of favorites we've collected
            let data = try encoder.encode(points)
            
            // Write the JSON to a file in the filename earlier
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Saved data to the Documents directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            print("Unable to write list of favorites to the Documents directory")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
    // loads the datat that was saved to the device
    // Loading our favorites:
    func loadPoints() {
        
        // Get a location under which to save the data
        let filename = getDocumentsDirectory().appendingPathComponent(pointsLabel)
        print(filename)
        
        //Attempt to load the data
        do {
            // Load raw data
            let data = try Data(contentsOf: filename)
            
            // Write the JSON to a file in the filename earlier
            print("Loaded data from the Documents directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
            // Decode the JSON into Swift native data structures
            // NOTE: we used [DadJoke] since we are loading into a list (array)
            points = try JSONDecoder().decode(Points.self, from: data)
            
        } catch {
            // What went wrong
            print("Could not load the data from the stores JSON file.")
            print("=========")
            print(error.localizedDescription)
            
        }
    }
    
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            DogView()
            
        }
    }
}

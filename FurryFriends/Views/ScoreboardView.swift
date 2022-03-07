//
//  ScoreboardView.swift
//  FurryFriends
//
//  Created by Madison Dellamea on 3/2/22.
//

import SwiftUI

struct ScoreboardView: View {
    
    //MARK: Stored Properties
    
    // Re-introduce variable points
    @State var points: Points = Points(dogs: 0, cats: 0)
    
    //MARK: Computed Properties
    
    var body: some View {
        
        VStack {
            
            // ternary condition operation
            Text(points.cats > points.dogs ? "You are a cat person!":"You are a dog person!")
                .font(.title)
                .underline()
                .foregroundColor(.pink)
                .background(.black)
            
        }
        
        .navigationTitle("What type of person are you?")
        
    }
    //MARK: function
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

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardView()
    }
}

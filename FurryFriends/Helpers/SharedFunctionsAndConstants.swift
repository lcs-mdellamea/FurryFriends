//
//  SharedFunctionsAndConstants.swift
//  DadJokes
//
//  Created by Madison Dellamea on 2/24/22.
//

import Foundation

// Return the location of the Documents directory for this app
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
    // Return the first path
    return paths[0]
}

// Define a filename/lable that we will write the data to in the directory.
let savedFavoritesLabel = "savedFavorites"
let pointsLabel = "savedPoints"

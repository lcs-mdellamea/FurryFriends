//
//  DogPicture.swift
//  FurryFriends
//
//  Created by Madison Dellamea on 3/2/22.
//

import Foundation

// The DogPicture structure conforms to the
// Decodable protocol. This means that we want
// Swift to be able to take a JSON object
// and 'decode' into an instance of this
// structure
struct DogPicture: Decodable, Hashable, Encodable {
    let message: String
    let status: String
}

//
//  CatPicture.swift
//  FurryFriends
//
//  Created by Madison Dellamea on 3/2/22.
//

import Foundation

// The CatPicture structure conforms to the
// Decodable protocol. This means that we want
// Swift to be able to take a JSON object
// and 'decode' into an instance of this
// structure
struct CatPicture: Decodable, Hashable, Encodable {
    let file: URL
}

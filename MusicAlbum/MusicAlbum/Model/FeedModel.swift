//
//  FeedModel.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation

struct Feed : Codable {
    var id:String
    var results:[MusicAlbumModel]
    
}

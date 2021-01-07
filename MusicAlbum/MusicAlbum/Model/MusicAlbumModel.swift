//
//  MusicAlbumModel.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation

struct MusicAlbumModel: Codable {
    var id:String?
    var artistName:String?
    var releaseDate:String?
    var name:String?
    var kind:String?
    var copyright:String?
    var artistId:String?
    var contentAdvisoryRating:String?
    var artistUrl:String?
    var artworkUrl100:String?
    var url:String?
    var genres:[Genre]
}



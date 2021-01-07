//
//  MusicAlbumViewModel.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation

class MusicAlbumViewModel {
    
    private let model:MusicAlbumModel
    
    var id:String {
        return model.id ?? ""
    }
    var artistName:String {
        return model.artistName ?? ""
    }
    var releaseDate:String {
        return model.releaseDate ?? ""
    }
    var name:String {
        return model.name ?? ""
    }
    var kind:String {
        return model.kind ?? ""
    }
    var copyright:String {
        return model.copyright ?? ""
    }
    var artistId:String {
        return model.artistId ?? ""
    }
    var contentAdvisoryRating:String {
        return model.contentAdvisoryRating ?? ""
    }
    var artistUrl:String {
        return model.artistUrl ?? ""
    }
    var artworkUrl100:String {
        return model.artworkUrl100 ?? ""
    }
    var url:String {
        return model.url ?? ""
    }
    
    init(model:MusicAlbumModel) {
        self.model = model
    }
}

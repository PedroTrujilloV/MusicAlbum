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
    
    var genres:Array<Genre> {
        return model.genres
    }
    
    var otherInfo:String {
        var text = ""
        var generes = ""
        
        var i = 0
        for genere in model.genres {
            if let genereName = genere.name {
                if i == model.genres.count - 1 {
                    generes = generes + "and " + genereName + "."
                } else {
                    generes = generes +  genereName + ", "
                }
            }
            i += 1
        }
        
        let releaseDate = model.releaseDate ?? "unknow"
        let copyright = model.copyright ?? "unknow"
        
        text = "Genres: " + generes + "\n Released: " + releaseDate + "\n Copyright: " + copyright
        
        return text
    }
    
    init(model:MusicAlbumModel) {
        self.model = model
    }
}

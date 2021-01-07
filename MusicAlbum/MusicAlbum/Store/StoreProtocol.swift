//
//  StoreProtocol.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation

protocol StoreDelegate:AnyObject {
    func storeDidLoad(dataSource:Array<MusicAlbumViewModel>)
}

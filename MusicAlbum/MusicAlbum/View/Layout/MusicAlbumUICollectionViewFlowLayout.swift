//
//  MusicAlbumUICollectionViewFlowLayout.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import UIKit

class MusicAlbumUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    static let spacing:CGFloat = 2
    static let columns = 3

    init(frame:CGRect) {
        super.init()
        self.sectionInset = UIEdgeInsets(top: 10, left: MusicAlbumUICollectionViewFlowLayout.spacing, bottom: 10, right: MusicAlbumUICollectionViewFlowLayout.spacing)
        self.minimumInteritemSpacing = MusicAlbumUICollectionViewFlowLayout.spacing
        self.minimumLineSpacing = MusicAlbumUICollectionViewFlowLayout.spacing
        let extraSpace = ( CGFloat(MusicAlbumUICollectionViewFlowLayout.columns) * MusicAlbumUICollectionViewFlowLayout.spacing ) + MusicAlbumUICollectionViewFlowLayout.spacing
        let sideLenght = ( frame.width - extraSpace ) / 3
        self.itemSize = CGSize(width: sideLenght, height: sideLenght)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

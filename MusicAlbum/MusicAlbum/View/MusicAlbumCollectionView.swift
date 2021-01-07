//
//  MusicAlbumCollectionView.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import UIKit

class MusicAlbumCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect) {
        let layout = MusicAlbumUICollectionViewFlowLayout(frame: frame)
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.alwaysBounceVertical = true
        self.register(MusicAlbumCollectionViewCell.self, forCellWithReuseIdentifier: MusicAlbumCollectionViewCell.reuserIdentifier)
    }

}

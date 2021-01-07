//
//  MusicAlbumsCollectionViewController.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import UIKit

class MusicAlbumsCollectionViewController: UICollectionViewController {
    
    let numberOfItemsInSection = 23
    private var store: MusicAlbumStore?
    private var dataSource:Array<MusicAlbumViewModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        setup()
    }
    
    private func setup(){
        store = MusicAlbumStore(delegate: self)
        navigationItem.title = "Music Albums"
        collectionView = MusicAlbumCollectionView(frame: collectionView.frame)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

extension MusicAlbumsCollectionViewController { // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicAlbumCollectionViewCell.reuserIdentifier, for: indexPath) as? MusicAlbumCollectionViewCell {
            let vm = dataSource[indexPath.item]
            cell.set(from: vm)
            return cell
        } else {
            print("Problem at dequeueReusableCell for MusicAlbumCollectionViewCell")
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: MusicAlbumCollectionViewCell.reuserIdentifier, for: indexPath)
    }
    
}

extension MusicAlbumsCollectionViewController: StoreDelegate {
    func  storeDidLoad(dataSource: Array<MusicAlbumViewModel>) {
        self.dataSource = dataSource
        self.collectionView?.reloadData()
    }
}

    
extension MusicAlbumsCollectionViewController { // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

//
//  MusicAlbumsCollectionViewController.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import UIKit

class MusicAlbumsCollectionViewController: UICollectionViewController {
    
    private var store: MusicAlbumStore?
    private var dataSource:Array<MusicAlbumViewModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let offerVM = dataSource[indexPath.row]
        let detailVC = MusicAlbumDetailViewController(offerVM)
        presentDetailViewController(detailVC)
        
    }
    
    private func presentDetailViewController(_ detailVC: MusicAlbumDetailViewController) {
       let nc = UINavigationController(rootViewController: detailVC)
       nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       nc.navigationBar.shadowImage = UIImage()
       nc.navigationBar.isTranslucent = true
       nc.view.backgroundColor = UIColor.clear
       
       self.present(nc, animated: true) {
           //do something
       }
    }
}

extension MusicAlbumsCollectionViewController: StoreDelegate {
    func  storeDidLoad(dataSource: Array<MusicAlbumViewModel>) {
        self.dataSource = dataSource
        self.collectionView?.reloadData()
    }
}


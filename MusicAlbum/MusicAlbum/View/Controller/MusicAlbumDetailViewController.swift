//
//  MusicAlbumDetailViewController.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/7/21.
//

import UIKit

class MusicAlbumDetailViewController: UIViewController{
    
    private var detailView: MusicAlbumDetailView?
    private var viewModel:MusicAlbumViewModel
    
    private let exitImage = UIImage(systemName: "xmark")
    
    
    init(_ viewModel: MusicAlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        setupView()
        setupButtons()
    }
    
    func setupButtons() {
        let exitButton = UIBarButtonItem(image: exitImage,
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(closeAction(sender:)))
        exitButton.tintColor = UIColor.systemGray
        self.navigationItem.leftBarButtonItem = exitButton
    }
    
    private func setupView() {
        viewRespectsSystemMinimumLayoutMargins = false
        self.title = "Details"
        let view = UIView()
        detailView = MusicAlbumDetailView(frame: self.view.frame, offerViewModel: self.viewModel)
        view.addSubview(self.detailView ?? UIView())
        self.view = view
    }
    
    
    @objc private func closeAction(sender:UIBarButtonItem) {
        dismiss(animated: true) {
            // do something
        }
    }
       
}

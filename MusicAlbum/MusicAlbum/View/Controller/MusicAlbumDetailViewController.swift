//
//  MusicAlbumDetailViewController.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/7/21.
//

import UIKit
import Combine

class MusicAlbumDetailViewController: UIViewController{
    
    private var detailView: MusicAlbumDetailView?
    private var viewModel:MusicAlbumViewModel
    private var cancellable:AnyCancellable?
    private static let processingQueue = DispatchQueue(label: "processingQueue")
    
//    private let heartFillImage = UIImage(systemName: "heart.fill")
    private let exitImage = UIImage(systemName: "xmark")
    
    
    init(_ viewModel: MusicAlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        self.cancel()
    }
    
    private func cancel(){
        cancellable?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        bind()
        setupView()
        setupButtons()
    }
    
    func bind(){
        
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
    
    @objc private func likeItAction(sender:UIBarButtonItem) {
        // do something
    }
    
    
    
    @objc private func closeAction(sender:UIBarButtonItem) {
        dismiss(animated: true) {
            // do something
        }
    }
       
}

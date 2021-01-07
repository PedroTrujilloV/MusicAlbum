//
//  MusicAlbumDetailView.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/7/21.
//

import UIKit
import Combine

class MusicAlbumDetailView: UIView {
    
    private var cancellable: AnyCancellable?

    private var thumbnailImageView:UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.layer.cornerRadius = 5
        imageV.layer.masksToBounds = true
        imageV.image = UIImage(named: "a-nikelogo")
        return imageV
    }()
    
    private var albumNameLabel: UILabel =  {
        let label = UILabel()
        label.text  = "No Album"
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.textColor = UIColor.albumNameTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var artistNameLabel: UILabel =  {
        let label = UILabel()
        label.text  = "No artist"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.textColor = UIColor.artistNameTextColor
        return label
    }()
    
    private var otherInfo:UILabel = {
       let label = UILabel()
        label.text  = "No genre, release date or copyright."
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.numberOfLines = 3
        return label
    }()

    
    private var textStackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 14.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var stackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let defaultImage = UIImage(named: "a-nikelogo")

    init(frame: CGRect, offerViewModel:  MusicAlbumViewModel) {
        super.init(frame: frame)
        setup()
        set(from: offerViewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
    private func setup(){

        setupStackView()
        setupStyle()
    }
    
    private func setupStyle() {
        self.backgroundColor = UIColor.systemBackground
    }
       
    private func setupStackView(){
        setupImageViewConstraints()
        setupTextConstraints()
        setupTextStackView()
        
        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)
        self.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    }
       
    private func setupTextConstraints(){
        albumNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width-20).isActive = true
        albumNameLabel.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width-30).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        otherInfo.widthAnchor.constraint(equalToConstant: self.frame.width-35).isActive = true
        otherInfo.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func setupTextStackView() {
        textStackView.addArrangedSubview(albumNameLabel)
        textStackView.addArrangedSubview(artistNameLabel)
        textStackView.addArrangedSubview(otherInfo)
    }
    
    public func set(from viewModel:MusicAlbumViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        otherInfo.text = viewModel.otherInfo
        bind(viewModel)
        
    }
    
    private func bind(_ viewModel: MusicAlbumViewModel) {
        if let imgUrl = URL(string: viewModel.url ){
            cancellable = ImageLoader.shared.loadImage(from: imgUrl)
                .handleEvents( receiveCompletion: { [weak self] (completion) in
                    DispatchQueue.main.async {
                        let margin:CGFloat = 16
                        self?.thumbnailImageView.image = self?.thumbnailImageView.image?.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
                    }
                })
                .assign(to: \.thumbnailImageView.image, on: self )
        }
    }
    
    
}

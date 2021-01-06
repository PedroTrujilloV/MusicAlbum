//
//  MusicAlbumCollectionViewCell.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import UIKit
import Combine

class MusicAlbumCollectionViewCell: UICollectionViewCell {
    static let reuserIdentifier: String = "MusicAlbumCollectionViewCellReuserIdentifier"
    private var cancellables: Array<AnyCancellable> = []
    private static let processingQueue = DispatchQueue(label: "processingQueue")
    private let heightProportion:CGFloat = 0.65
    
    private let defaultImage = UIImage(named: "a-nikelogo")
    private let likeStateImageView = UIImageView(image: UIImage(systemName: "heart.fill") )
    private var imageView = UIImageView()
    private var albumNameLabel = UILabel()
    private var artistNameLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let stackView   = UIStackView()
    private let textStackView   = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        self.cancel()
    }
    
    private func cancel(){
        _ = cancellables.map{ $0.cancel()}
    }
    
    func setup(){
        setupImageView()
        setupText()
        setupStackView()
        setupIcons()
    }
    
    private func setupImageView(){
        imageView.backgroundColor = UIColor.cellImageBackgroundColor
        imageView.heightAnchor.constraint(equalToConstant: self.frame.width * heightProportion).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.image = defaultImage
    }
    
    private func setupText(){
        albumNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        albumNameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        albumNameLabel.text  = "-$0.00 cash back :("
        albumNameLabel.textAlignment = .left
        albumNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        albumNameLabel.textColor = UIColor.albumNameTextColor
        
        artistNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        artistNameLabel.text  = "none product :("
        artistNameLabel.textAlignment = .left
        artistNameLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        artistNameLabel.textColor = UIColor.artistNameTextColor
    }
    
    private func setupStackView(){
        textStackView.axis  = NSLayoutConstraint.Axis.vertical
        textStackView.distribution  = UIStackView.Distribution.fillEqually
        textStackView.alignment = UIStackView.Alignment.center
        textStackView.spacing   = 3.0

        textStackView.addArrangedSubview(albumNameLabel)
        textStackView.addArrangedSubview(artistNameLabel)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)
        activityIndicator.startAnimating()
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupIcons(){
        likeStateImageView.tintColor = UIColor.nikeColor
        likeStateImageView.isHidden = true
        let yPos:CGFloat = self.frame.size.height - (self.frame.size.height * heightProportion)
        activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: yPos)
        self.addSubview(activityIndicator)
        self.addSubview(likeStateImageView)
    }

        
    public func set(from viewModel:  MusicAlbumViewModel) {
//        bind(viewModel)
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
    
    
    override func prepareForReuse() {
        imageView.image = defaultImage
        self.likeStateImageView.isHidden = true
        self.cancel()
    }
}

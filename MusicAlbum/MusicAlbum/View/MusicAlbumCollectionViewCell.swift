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
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing  = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var thumbnailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cellImageBackgroundColor
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "a-nikelogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text  = "No Album"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.textColor = UIColor.albumNameTextColor
        label.numberOfLines = 2
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text  = "No Artist"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textColor = UIColor.artistNameTextColor
        return label
    }()
    
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
        setupStackView()
        setupIcons()
    }
       
    private func setupStackView(){
        setupImageViewConstraints()
        setupTextViewConstraints()

        stackView.addArrangedSubview(thumbnailImageView)
        stackView.addArrangedSubview(textStackView)

        self.addSubview(stackView)
        activityIndicator.startAnimating()
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupImageViewConstraints(){
        thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    }
    
    private func setupTextViewConstraints(){
        albumNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 6).isActive = true
        albumNameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        artistNameLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 8).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true

        textStackView.addArrangedSubview(albumNameLabel)
        textStackView.addArrangedSubview(artistNameLabel)
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
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        bindImage(viewModel)
    }
    
    private func bindImage(_ viewModel: MusicAlbumViewModel) {
        if let imgUrl = URL(string: viewModel.artworkUrl100 ){
            cancellables.append(
                ImageLoader.shared.loadImage(from: imgUrl)
                    .handleEvents(receiveSubscription: { [weak self] (subscription) in
                            DispatchQueue.main.async {
                                self?.activityIndicator.startAnimating()
                            }
                        }, receiveCompletion: { [weak self] (completion) in
                            DispatchQueue.main.async {
                                self?.activityIndicator.stopAnimating()
                                let margin:CGFloat = 10
                                self?.thumbnailImageView.image = self?.thumbnailImageView.image?.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
                            }
                        }, receiveCancel: { [weak self]  in
                            DispatchQueue.main.async {
                                self?.activityIndicator.stopAnimating()
                            }
                    })
                    .assign(to: \.image, on: thumbnailImageView )
            )
        }
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = defaultImage
        self.likeStateImageView.isHidden = true
        self.cancel()
    }
}

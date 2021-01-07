//
//  MusicAlbumStore.swift
//  MusicAlbum
//
//  Created by Pedro Trujillo on 1/6/21.
//

import Foundation
import Combine


class MusicAlbumStore {
    
    private let urlString:String = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    private let urlProcessingQueue = DispatchQueue(label: "urlProcessingQueue")
    private var cancellable: AnyCancellable?
    private weak var delegate:StoreDelegate?
    private var albumList:Array<MusicAlbumViewModel> = []
    
    init(delegate:StoreDelegate) {
        guard let url = URL(string: urlString) else {print("There was a problem getting URL from: \(urlString)"); return}
        load(url: url)
        self.delegate = delegate
    }
    
    private func load(url:URL){
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: urlProcessingQueue)
            .receive(on:DispatchQueue.main)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                return element.data
            }
            .decode(type: Result.self, decoder: JSONDecoder() )
            .eraseToAnyPublisher()
            .sink(receiveCompletion: {completion in
                print("Received completion: \(completion).")
                switch completion {
                case .finished:
                    print("JSON loaded!")
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { [weak self]  result in
                self?.albumList = result.feed.results.map({MusicAlbumViewModel(model: $0)})
                self?.delegate?.storeDidLoad(dataSource: self?.albumList ?? [])
            })
        
        self.cancellable?.cancel()
    }
    
    
}

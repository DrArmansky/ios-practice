//
//  ImageNetworkService.swift
//  ImageCache
//
//  Created by Kira on 08.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Moya

class ImageNetworkService: ImageNetworkable {
    var provider = MoyaProvider<ImageNetworkAPI>()
    
    func getData(completion: @escaping ([ImageResponseModel]?, Error?) -> ()) {
        provider.request(.get) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([ImageResponseModel].self, from: value.data)
                    completion(posts, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func download(url: URL, completion: @escaping (Image?, Error?) -> ()) {
        provider.request(.download(url: url)) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                let downloadedImage = try? response.mapImage()
                guard let image = downloadedImage else { return }
                completion(image, nil)
            }
        }
    }
}

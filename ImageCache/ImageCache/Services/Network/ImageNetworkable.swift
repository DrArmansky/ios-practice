//
//  ImageNetworkable.swift
//  ImageCache
//
//  Created by Kira on 08.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import Moya

protocol ImageNetworkable {
    var provider: MoyaProvider<ImageNetworkAPI> { get }
    
    func getData(completion: @escaping ([ImageResponseModel]?, Error?) -> ())
    func download(url: URL, completion: @escaping (Image?, Error?) -> ())
}

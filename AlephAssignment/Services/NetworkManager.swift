//
//  NetworkManager.swift
//  AlephAssignment
//
//  Created by DuyN on 7/18/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class NetworkManager {
    // MARK: - Properties
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager(baseURL: URL(string:"http://dev.aleph-labs.com/")!)
        return networkManager
    }()
    
    // MARK: - Fields
    
    let baseURL: URL
    
    // MARK: - Initialization
    
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: - Accessors
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    func getProducts(url: String, completionHandler: @escaping ( ([Product]?, Error?)->Void) )  {
        Alamofire.request(baseURL.appendingPathComponent(url), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<ProductResponse>) in
            switch response.result {
            case .success(let productResponse):
                completionHandler(productResponse.items, nil)
                break
            case .failure(let error):
                completionHandler(nil, error)
                break
            }
        }
    }
}

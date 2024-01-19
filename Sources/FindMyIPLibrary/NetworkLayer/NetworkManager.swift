//
//  NetworkManager.swift
//  FindMyIP
//
//  Created by Narendran Elumalai on 19/01/24.
//

import Foundation
import Combine
import Alamofire

protocol NetworkProtocol{
    func getIpAPI() -> AnyPublisher<GetIPAPIResponse,AFError>
}

class NetworkManager:NetworkProtocol{
    func getIpAPI() -> AnyPublisher<GetIPAPIResponse, AFError> {
        
        let url = URL(string: "https://ipapi.co/json/")!
        
        let headers : HTTPHeaders  = ["Accept":"application/json"]
        
        return AF.request(url,method: .get,parameters: [:],headers: headers)
            .validate()
            .publishDecodable(type:GetIPAPIResponse.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
}

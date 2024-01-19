//
//  MockNetworkManager.swift
//  FindMyIP
//
//  Created by Narendran Elumalai on 19/01/24.
//

import Foundation
import Combine
import Alamofire

class MockNetworkManager:NetworkProtocol{
 
    var isSucessResponse:Bool = false
    
    init(isSucessResponse:Bool) {
        self.isSucessResponse = isSucessResponse
    }
    
    var mockresponse = GetIPAPIResponse(ip: "10.20.81", network: "Wifi", version: "1.20", city: "Chennai", region: "India", regionCode: "004", country: "+91", countryName: "India", countryCode: "+91", countryCodeIso3: "00", countryCapital: "Delhi", countryTLD: "", continentCode: "00", inEu: false, postal: "600066", latitude: 10.20, longitude: 10.30, timezone: "+5.30", utcOffset: "+5.30", countryCallingCode: "+91", currency: "INR", currencyName: "Rupee", languages: "Hindi", countryArea: 1, countryPopulation: 100000, asn: "aaa", org: "Photon")
    
    func getIpAPI() -> AnyPublisher<GetIPAPIResponse, AFError> {
        if !isSucessResponse{
            return Fail(error: AFError.invalidURL(url: "htts://ip.details/"))
                .eraseToAnyPublisher()
        }else{
            return Just(mockresponse)
                .setFailureType(to: AFError.self)
                .eraseToAnyPublisher()
        }
    }
    
}

//
//  GetIPViewModel.swift
//  FindMyIP
//
//  Created by Narendran Elumalai on 19/01/24.
//

import Foundation
import Combine

class GetIPViewModel : ObservableObject{
    
    @Published var getIpResponse:GetIPAPIResponse?
    
    var networking: NetworkProtocol?
    var subscriptions : Set<AnyCancellable> = []
    
    
    
    init(networking: NetworkProtocol) {
        self.networking = networking
    }
    
    func getIpApi(){
        
        networking?.getIpAPI()
            .sink(receiveCompletion: { result in
                print(result)
            }, receiveValue: { response in
                self.getIpResponse = response
                
            })
            .store(in: &subscriptions)
        
    }
}

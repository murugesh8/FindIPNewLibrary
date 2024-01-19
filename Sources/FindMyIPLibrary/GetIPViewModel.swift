//
//  GetIPViewModel.swift
//  FindMyIP
//
//  Created by Narendran Elumalai on 19/01/24.
//

import Foundation
import Combine


enum AppState{
    case initial
    case loading
    case Sucess
    case failure
    
}
class GetIPViewModel : ObservableObject{
    
    @Published var getIpResponse:GetIPAPIResponse?
    
    @Published var state:AppState = .initial
    
    var networking: NetworkProtocol?
    var subscriptions : Set<AnyCancellable> = []
    
    
    
    init(networking: NetworkProtocol) {
        self.networking = networking
    }
    
    func getIpApi(){
        self.state = .loading
        networking?.getIpAPI()
            .sink(receiveCompletion: {[weak self] result in
                guard self != nil else {
                    self?.state = .failure
                    return
                }
                
            }, receiveValue: { response in
                self.getIpResponse = response
                self.state = .Sucess

            })
            .store(in: &subscriptions)
        
    }
}


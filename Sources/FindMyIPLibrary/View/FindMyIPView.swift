//
//  ContentView.swift
//  FindMyIP
//
//  Created by Narendran Elumalai on 19/01/24.
//

import SwiftUI


public struct FindMyIPView: View {
    
    @StateObject var getIpViewModel : GetIPViewModel = GetIPViewModel(networking: NetworkManager())
    
    public init() {
        
    }
    
    public var body: some View {
        
        NavigationStack{
            
            ZStack{
                
                VStack{
                    
                    if let response = getIpViewModel.getIpResponse{
                        
                        ScrollView{
                            LazyVStack(alignment: .leading) {
                               
                                commonFieldView(key: "IP:", value: response.ip)
                                
                                commonFieldView(key: "City:", value: response.city)

                                commonFieldView(key: "ASN:", value: response.asn)
                                
                                commonFieldView(key: "Country:", value: response.country)

                                commonFieldView(key: "Country Population:", value: response.countryPopulation)
                                
                                commonFieldView(key: "Country Area:", value: response.countryArea)

                                commonFieldView(key: "Country Calling Code:", value: response.countryCallingCode)
                                
                                commonFieldView(key: "Country Captial:", value: response.countryCapital)

                                commonFieldView(key: "Country Name:", value: response.countryName)
                               
                                commonFieldView(key: "Country Languages:", value: response.languages)

                                commonFieldView(key: "Latitude:", value: response.latitude)
                                   
                                commonFieldView(key: "Longitude:", value: response.longitude)

                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.size.width)
                        }
                    }else{
                        Text("Something Went Wrong")
                            .font(.system(size: 15,weight: .bold))

                    }
                }
                .navigationTitle("IP Details")
                .navigationBarTitleDisplayMode(.large)
                

            }
        }
        .onAppear(){
            getIpViewModel.getIpApi()
        }
 
    }
    
    func commonFieldView<T:CustomStringConvertible>(key:String, value:T) -> some View{
        HStack{
            Text(key)
                .font(.system(size: 15,weight: .bold))
            Text(value.description)
                .font(.system(size: 15,weight: .medium))
        }
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .padding()
       
        
    }
}

#Preview {
    FindMyIPView()
}

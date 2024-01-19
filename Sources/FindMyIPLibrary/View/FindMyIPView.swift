//
//  ContentView.swift
//  FindMyIP
//
//  Created by Narendran Elumalai on 19/01/24.
//

import SwiftUI


public struct FindMyIPView: View {
    
    @StateObject var getIpViewModel : GetIPViewModel = GetIPViewModel(networking: NetworkManager())
    
    @State var isButtonTapped: Bool = false
    
    public init() {
        
    }
    
    public var body: some View {
        
        NavigationStack{
            
            VStack{
                switch getIpViewModel.state {
                case .initial:
                    initialView()
                case .loading:
                    ProgressView()
                        .tint(Color.blue)
                case .Sucess:
                    ipDetailsListView
                case .failure:
                    errorView()
                }
            }
            .navigationTitle("IP Details")
            .navigationBarTitleDisplayMode(.large)
        
        }
       
 
    }
    
    var ipDetailsListView:some View{
        
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
                    
                }
                
            }
           


        }
    }
    
    
    func initialView() -> some View{
        Button {
            isButtonTapped = true
            getIpViewModel.getIpApi()

        } label: {
            VStack{
                Text("Get IP Details")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundColor(Color.blue)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: 100,height: 50)
                    
                    Text("Click Here")
                        .font(.system(size: 15,weight: .medium))
                        .foregroundColor(Color.white)

                    
                }
            }
        
                
        }
    }
    
    func errorView() -> some View{
        Text("Something went wrong")
            .font(.system(size: 15,weight: .bold))
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

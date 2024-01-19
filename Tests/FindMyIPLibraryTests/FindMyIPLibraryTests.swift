import XCTest
import Combine
import Alamofire

@testable import FindMyIPLibrary


final class FindMyIPTests: XCTestCase {
    

    var networking:NetworkProtocol?
    var subscriptions : Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIPAPISucess(){
        let mockNetwork = MockNetworkManager(isSucessResponse: true)
        
        let expected  = GetIPAPIResponse(ip: "10.20.81", network: "Wifi", version: "1.20", city: "Chennai", region: "India", regionCode: "004", country: "+91", countryName: "India", countryCode: "+91", countryCodeIso3: "00", countryCapital: "Delhi", countryTLD: "", continentCode: "00", inEu: false, postal: "600066", latitude: 10.20, longitude: 10.30, timezone: "+5.30", utcOffset: "+5.30", countryCallingCode: "+91", currency: "INR", currencyName: "Rupee", languages: "Hindi", countryArea: 1, countryPopulation: 100000, asn: "aaa", org: "Photon")

        mockNetwork.getIpAPI()
            .sink { result in
                switch result{
                case .finished:
                    break;
                case .failure(_):
                    XCTFail("Test Case Failed")
                }
            } receiveValue: { response in
                
                XCTAssertEqual(expected, response)
            }
            .store(in: &subscriptions)

    }
    
    
    func testIPAPIFailure(){
        let mockNetwork = MockNetworkManager(isSucessResponse: false)
        
        let errorExpected  = AFError.invalidURL(url: "htts://ip.details/")

        mockNetwork.getIpAPI()
            .sink { result in
                switch result{
                case .finished:
                    XCTFail("Test Case Failed")
                    
                case .failure(let error):
                    XCTAssertEqual(errorExpected.localizedDescription,error.localizedDescription)
                }
            } receiveValue: { response in
                XCTFail("Test Case Failed")
            }
            .store(in: &subscriptions)

    }

}


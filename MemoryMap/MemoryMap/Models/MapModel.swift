//Created by Vladislav Khrisanov (xkhris00)

import Foundation
import MapKit

//Data model for JSON
struct Address: Codable {
    let data: [Results]
}

struct Results: Codable, Hashable {
    let latitude, longitude: Double
    let label: String?
    let name: String?
}

//Making a request
class MapModel: ObservableObject {
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY = "7084e835583947c30e532e088953b547"
    
    @Published var position: MKCoordinateRegion
    @Published var addresses: Address?
    
    //Initializing a map
    init() {
        self.position = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.195061, longitude: 16.606836), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    }
    
    //API request to get location data
    func getLocation(address: String) {
        let tmpAddress = address.replacingOccurrences(of: " ", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(tmpAddress)"
        
        guard let url = URL(string: url_string) else {
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { [weak self](data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let addresses = try JSONDecoder().decode(Address.self, from: data)
                DispatchQueue.main.async {
                    self?.addresses = addresses
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //Displaying a chosen location on the map
    func setLocation(latitude: Double, longitude: Double) {
        DispatchQueue.main.async {
            self.position = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        }
    }
}



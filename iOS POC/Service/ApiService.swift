//
//  ApiService.swift
//  iOS POC
//
//  Created by NanduV on 08/03/22.
//

import Foundation
import Alamofire

class ApiService {
    
    func fetchWeatherData(urlString: String, completion: @escaping (Bool, Data?) -> ()) {
        AF.request(urlString, method: .get).responseJSON { response in
            
            guard let weatherData = response.data else {
                completion(false, nil)
                       print("failure")
                       return
                   }
                completion(true, weatherData)
               }
        }
}

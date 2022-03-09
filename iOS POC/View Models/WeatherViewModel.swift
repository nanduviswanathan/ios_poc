//
//  WeatherViewModel.swift
//  iOS POC
//
//  Created by NanduV on 07/03/22.

import Foundation
import CoreLocation
import SideMenu

class WeatherViewModel {
    
    var apiService:ApiService = ApiService()
    
    var geocoder = CLGeocoder()
    
    // get weather
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?) -> ())  {
        let urlString = "\(Constants.weatherInfo.weatherURL)\(Constants.weatherInfo.appId)&lat=\(latitude)&lon=\(longitude)"
        
        print(urlString)
        apiService.fetchWeatherData(urlString: urlString, completion: { (success, weather) in
            
            if(success) {
                if let safeData = weather {
                    if let weekWeather = self.parseJSON(safeData) {
                        completion(weekWeather)
                    }
                }
            } else {
                completion(nil)
            }
        })
    }
    
    
    // fetch lat and long from city name
    func getLatandLongFromCity(cityName: String, completion: @escaping (WeatherModel?) -> ()){
        
        let city = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(city.isEmpty) {
            completion(nil)
            return
        }
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
                print( "Unable to Find Location for Address")
                completion(nil)

            } else {
                var location: CLLocation?

                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }

                if let location = location {
                    let coordinate = location.coordinate
                    print("\(coordinate.latitude), \(coordinate.longitude)")
                    self.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude, completion: {(result) in
                        completion(result)
                    })
                } else {
                    print("No Matching Location Found")
                    completion(nil)
                }
            }
           }
    }

    //parse json response
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        var tempArray: [Double]  = []
        var dateArray: [String] = []
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           
            for index in 0..<decodedData.daily.count {
                tempArray.append(( decodedData.daily[index].temp.day))
                dateArray.append(getTimeFromUTC(timeResult: Double(decodedData.daily[index].dt)))
            }
            let weather = WeatherModel(dateTime: dateArray, temperature: tempArray)
            return weather

        } catch {
            return nil
        }
    }
    
    // get date as string
    func getTimeFromUTC(timeResult: Double ) -> String {
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        let components = localDate.components(separatedBy: ",")
        return components[0]
    }
}

//
//  APIRequest.swift
//  WorldHolidays
//
//  Created by Paweł Brzozowski on 01/11/2021.
//

import Foundation

enum HolidayError:Error {
    case noDataAvalible
    case canNotProcessData
}

struct HolidayReguest {
    let url: URL
    let apiKey = "9a213652ff98b475cbf57c7a0f91da42f1c79174"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(apiKey)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.url = resourceURL
    }
    
    func getData(completion: @escaping(Result<[Holiday], HolidayError>) -> Void) {
        // This aproach happens async.
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvalible))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        // start dowloading data form API
        dataTask.resume()
    }
}

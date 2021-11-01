//
//  Holiday.swift
//  WorldHolidays
//
//  Created by Paweł Brzozowski on 01/11/2021.
//


// Creating model for data from API
import Foundation

struct response: Decodable{
    var response: Holidays
}
struct Holidays:Decodable {
    var holidays: [Holiday]
}
struct Holiday:Decodable{
    var name: String
    var date: DateObject
}

struct DateObject: Decodable  {
    // Important to have same variable names as in API
    var iso: String
}

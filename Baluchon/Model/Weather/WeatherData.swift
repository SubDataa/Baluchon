//
//  WeatherStruct.swift
//  Baluchon
//
//  Created by Thibault Ballof on 03/03/2022.
//

import Foundation
// MARK: - DECODE JSON
struct WeatherData: Codable {
    
    let coord : Coord
    let weather : [Weather]
    let main : Main
    let name : String

    struct Coord : Codable {
        let lon : Double
        let lat : Double
    }

    struct Weather : Codable {
        let description : String
        let icon : String
    }
    
    struct Main : Codable {
        let temp : Double
    }
}

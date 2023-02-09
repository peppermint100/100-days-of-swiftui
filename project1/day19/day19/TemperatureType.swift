//
//  TemperatureType.swift
//  day19
//
//  Created by peppermint100 on 2023/02/08.
//

import Foundation

// rawValue 값을 사용하기 위해서는 String을 상속받아야 한다.
// enum을 전부 이터레이트 할 수 있는 메소드를 사용하려면 CaseIterable을 상속받아야 한다.
enum TemperatureType: String, CaseIterable {
    case celsius, fahrenheit, kelvin
    
    func convert(
        _ temperature: Double,
        to targetType: TemperatureType) -> Double {
            
            switch self {
            case .celsius:
                if targetType == .fahrenheit {
                    return (temperature * 9/5) + 32
                } else if targetType == .kelvin {
                    return temperature + 273.15
                }
                return temperature
            case .fahrenheit:
                 if targetType == .celsius {
                     return (temperature - 32) * 5/9
                } else if targetType == .kelvin {
                    return (temperature - 32) * 5/9 + 273.15
                }
                return temperature
            case .kelvin:
                if targetType == .fahrenheit {
                    return (temperature - 273.15) * 9/5 + 32
                } else if targetType == .celsius {
                    return temperature - 273.15
                }
                return temperature
            }
    }
    
}

//
//  RSPType.swift
//  milestone1
//
//  Created by peppermint100 on 2023/02/11.
//

import Foundation


enum RSPType: String, CaseIterable {
    case rock, scissors, paper
    
    func beats(_ target: RSPType) -> Bool {
        if self.equals(.rock) && target.equals(.scissors){
            return true
        }
        
        if self.equals(.scissors) && target.equals(.paper){
            return true
        }
        
        if self.equals(.paper) && target.equals(.rock){
            return true
        }
        
        return false
    }
    
    func equals (_ target: Self) -> Bool {
        return target.rawValue == self.rawValue
    }
    
    static func random() -> RSPType {
        var allCases = RSPType.allCases
        allCases.shuffle()
        return allCases[0]
    }
}

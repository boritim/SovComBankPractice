//
//  TimeInterval+ObtainFormattedString.swift
//  SCBMonitorSwift
//
//  Created by Renat Murtazin on 16.07.2022.
//

import UIKit

extension TimeInterval {
    
    func obtainFormattedString() -> String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60
        let second = Int(self) % 60
        
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}

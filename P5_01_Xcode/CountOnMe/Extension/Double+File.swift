//
//  File.swift
//  CountOnMe
//
//  Created by Mickael PAYAN on 26/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension Double {
    func removeZeroFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return String(formatter.string(from: number) ?? "\(self)")
    }
}

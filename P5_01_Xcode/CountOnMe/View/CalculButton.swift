//
//  CalculButton.swift
//  CountOnMe
//
//  Created by Mickael PAYAN on 26/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit

@IBDesignable final class CalculButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 8, height: 8)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    }
}

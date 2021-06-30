//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class CalculationViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var plusButton: CalculButton!
    @IBOutlet private weak var minusButton: CalculButton!
    @IBOutlet private weak var multiplyButton: CalculButton!
    @IBOutlet private weak var divideButton: CalculButton!
    
    private let calculation = Calculation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculation.displayResultHandler = { [self] result in
            textView.text = result
        }
        calculation.clearAll()
    }
}

private extension CalculationViewController {
    @IBAction func tappedClearButton() {
        calculation.clearAll()
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculation.addNumber(String(sender.tag-1))
    }
    
    @IBAction func tappedOperator(_ sender: UIButton) {
        switch sender {
        case plusButton:
            calculation.addOperator(" + ")
        case minusButton:
            calculation.addOperator(" - ")
        case multiplyButton:
            calculation.addOperator(" x ")
        case divideButton:
            calculation.addOperator(" / ")
        default:
            break
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculation.resolveOperation()
    }
}

//
//  Calculation.swift
//  CountOnMe
//
//  Created by Mickael PAYAN on 26/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculation {

    var displayResultHandler: (_ result: String) -> Void = {_ in }

    private var displayCalculText = "" {
        didSet {
            displayResultHandler(displayCalculText)
        }
    }

    func clearAll() {
        displayCalculText = "0"
    }

    func addNumber(_ number: String) {
        if displayCalculText == "0" || displayCalculText.contains("=") {
            displayCalculText = ""
        }
        displayCalculText += displayCalculText + String(number)
    }

    func addOperator(_ operator: String) {
        replaceOperator()
        displayCalculText.append(`operator`)
        if displayCalculText.contains("=") {
            resolveOperation()
        }
    }

    func replaceOperator() {
        if !canAddOperator {
            displayCalculText.removeLast(3)
        }
    }

    func resolveOperation() {
        guard expressionIsCorrect, expressionHaveEnoughElement else {
            return replaceOperator()
        }
        var operationsToReduce = elements
        while operationsToReduce.count > 1 {
            var operandIndex = 1
            // To manage the priority of calculations
            if let index = operationsToReduce.firstIndex(where: { $0.contains("x") || $0.contains("/")}) {
                operandIndex = index
            }
            // Left and right corresponding to the numbers on the left and right the operator. 
            guard let left = Double(operationsToReduce[operandIndex-1]),
                  let right = Double(operationsToReduce[operandIndex+1]) else {
                return
            }
            let operand = operationsToReduce[operandIndex]
            var result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: return
            }
            operationsToReduce.remove(at: operandIndex+1)
            operationsToReduce.remove(at: operandIndex-1)
            operationsToReduce.insert("\(result.removeZeroFromEnd())", at: operandIndex)
            operationsToReduce.remove(at: operandIndex-1)
        }
        displayCalculText.append(" = \(operationsToReduce.first!)")

        // To handle division by zero. Otherwise 0/0 = ∞ and 1/0 = + ∞
        if displayCalculText.contains("∞") || displayCalculText.contains("NaN") {
            displayCalculText = "Error"
        }
    }
}

private extension Calculation {
    var elements: [String] {
        return displayCalculText.split(separator: " ").map { "\($0)" }
    }

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
}

//
//  CaculatorBrain.swift
//  Calculator
//
//  Created by Kelvin Leung on 08/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        //  funtion is also a TYPE
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equal
    }
    
    //  use dictionary to put all the possible operations together
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        //  use closure to simplify the syntax
        "±": Operation.unaryOperation({ -$0 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equal
    ]
    
    //  use struct to store temporary state
    private struct PendingBinaryOperation {
        let funtion: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return funtion(firstOperand, secondOperand)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?

    //  "mutating" the struct property
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
        }
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
                case .constant(let value):
                    accumulator = value
                case .unaryOperation(let funtion):
                    if let operand = accumulator {
                        accumulator = funtion(operand)
                    }
                case .binaryOperation(let funtion):
                    if let operand = accumulator {
                        //  struct's "init"
                        pendingBinaryOperation = PendingBinaryOperation(funtion: funtion, firstOperand: operand)
                        accumulator = nil
                    }
                case .equal:
                    performPendingBinaryOperation()
            }
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}

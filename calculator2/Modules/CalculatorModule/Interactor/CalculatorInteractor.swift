//
//  CalculatorInteractor.swift
//  calculator2
//
//  Created by Suzan Tekin on 1.12.2023.
//

import Foundation

protocol CalculatorInteractorProtocol: AnyObject {
    func evaluateMathExpression(_ expression: String) -> Double?
}

class CalculatorInteractor: CalculatorInteractorProtocol {
    weak var presenter: CalculatorPresenterProtocol!

    init(presenter: CalculatorPresenterProtocol) {
        self.presenter = presenter
    }

    func evaluateMathExpression(_ expression: String) -> Double? {
        let mathExpression = NSExpression(format: expression)

        if let result = mathExpression.expressionValue(with: nil, context: nil) as? Double {
            return result
        } else {
            print("Failed to evaluate the expression.")
            return nil
        }
    }
}

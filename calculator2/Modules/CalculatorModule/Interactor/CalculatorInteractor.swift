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
        var modifiedExpression = convertSqrtExpression(expression)
        modifiedExpression = convertPowExpression(modifiedExpression)
        modifiedExpression = evaluateFactorialExpression(modifiedExpression)
        modifiedExpression = evaluateModExpression(modifiedExpression)
        modifiedExpression = modifiedExpression.replacingOccurrences(of: "−", with: "-")
        modifiedExpression = modifiedExpression.replacingOccurrences(of: "×", with: "*")
        modifiedExpression = modifiedExpression.replacingOccurrences(of: "÷", with: "/")
        modifiedExpression = modifiedExpression.replacingOccurrences(of: "π", with: "3.141592653589793")
        do {
            let mathExpression = NSExpression(format: modifiedExpression)

            print("")

            if let result = mathExpression.expressionValue(with: nil, context: nil) as? Double {
                return result
            } else {
                print("Failed to evaluate the expression.")
                return nil
            }
        } catch {
            return nil
        }
    }

    func convertSqrtExpression(_ expression: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "√(\\d+)", options: .caseInsensitive)

            let range = NSRange(location: 0, length: expression.utf16.count)
            var result = expression

            regex.enumerateMatches(in: expression, options: [], range: range) { match, _, _ in
                guard let matchRange = match?.range else { return }

                let substring = (expression as NSString).substring(with: matchRange)
                let replacement = "sqrt(" + substring.dropFirst() + ")"
                result = result.replacingOccurrences(of: substring, with: replacement)
            }

            return result
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return expression
        }
    }

    func convertPowExpression(_ expression: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+)\\^(\\d+)", options: .caseInsensitive)
            let range = NSRange(location: 0, length: expression.utf16.count)
            var result = expression

            regex.enumerateMatches(in: expression, options: [], range: range) { match, _, _ in
                guard let matchRange = match?.range else { return }

                let substring = (expression as NSString).substring(with: matchRange)
                let components = substring.components(separatedBy: "^")

                if components.count == 2, let base = Double(components[0]), let exponent = Double(components[1]) {
                    let replacement = String(pow(base, exponent))
                    result = result.replacingOccurrences(of: substring, with: replacement)
                }
            }
            return result
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return expression
        }
    }

    func factorial(_ n: Double) -> Double {
        return n == 0 ? 1 : n * factorial(n - 1)
    }

    func evaluateFactorialExpression(_ expression: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+)!", options: .caseInsensitive)
            let range = NSRange(location: 0, length: expression.utf16.count)
            var modifiedExpression = expression

            regex.enumerateMatches(in: expression, options: [], range: range) { match, _, _ in
                guard let matchRange = match?.range else { return }

                let substring = (expression as NSString).substring(with: matchRange)
                let number = Double(substring.dropLast())
                let replacement = "\(factorial(number!))"
                modifiedExpression = modifiedExpression.replacingOccurrences(of: substring, with: replacement)
            }
            return modifiedExpression
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return expression
        }
    }

    func evaluateModExpression(_ expression: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+)\\%(\\d+)", options: .caseInsensitive)
            let range = NSRange(location: 0, length: expression.utf16.count)
            var result = expression

            regex.enumerateMatches(in: expression, options: [], range: range) { match, _, _ in
                guard let matchRange = match?.range else { return }

                let substring = (expression as NSString).substring(with: matchRange)
                let components = substring.components(separatedBy: "%")

                if components.count == 2, let base = Int(components[0]), let exponent = Int(components[1]) {
                    let replacement = String(base % exponent)
                    result = result.replacingOccurrences(of: substring, with: replacement)
                }
            }
            return result
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return expression
        }
    }
}

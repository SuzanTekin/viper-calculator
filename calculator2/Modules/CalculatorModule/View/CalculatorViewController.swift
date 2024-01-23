//
//  CalculatorViewController.swift
//  calculator2
//
//  Created by Suzan Tekin on 1.12.2023.
//

import UIKit

extension Double {
    var string: String {
        if self > Double(Int(self)) {
            return String(self)
        }
        return String(Int(self))
    }
}

protocol CalculatorViewProtocol: AnyObject {
    func updateDescriptionText(_ text: String)
    func updateResultText(_ text: String)
    func getDescriptionText() -> String?
    func clearDescriptionText()
    func removeLastCharacterFromDescriptionText()
    func appendToDescriptionText(_ text: String)
}

class CalculatorViewController: UIViewController, CalculatorViewProtocol {
    func clearDescriptionText() {
        descriptionText.text = ""
        realDecriptionText = ""
    }

    func removeLastCharacterFromDescriptionText() {
        if var descriptionText = descriptionText.text, !descriptionText.isEmpty {
            descriptionText.removeLast()
            realDecriptionText.removeLast()
            updateDescriptionText(realDecriptionText)
        }
    }

    func appendToDescriptionText(_ text: String) {
        realDecriptionText += text
        updateDescriptionText(realDecriptionText)
    }

    func getDescriptionText() -> String? {
        return realDecriptionText
    }

    func updateDescriptionText(_ text: String) {
        realDecriptionText = text
        var newText = replacePowerNotation(text)
        descriptionText.text = newText.replacingOccurrences(of: "^", with: "")
    }

    func replacePowerNotation(_ expression: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+)\\^(\\d+)", options: .caseInsensitive)

            let range = NSRange(location: 0, length: expression.utf16.count)
            var result = expression
            regex.enumerateMatches(in: expression, options: [], range: range) { match, _, _ in
                guard let matchRange = match?.range else { return }

                let substring = (expression as NSString).substring(with: matchRange)
                let components = substring.components(separatedBy: "^")

                if components.count == 2, let base = Double(components[0]), let exponent = Double(components[1]) {
                    let replacement = "\(base.string)\(superscriptDigits(for: String(exponent.string)))"
                    result = result.replacingOccurrences(of: substring, with: replacement)
                }
            }

            return result
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return expression
        }
    }

    func superscriptDigits(for number: String) -> String {
        let superscriptDigits: [Character: String] = [
            "0": "⁰",
            "1": "¹",
            "2": "²",
            "3": "³",
            "4": "⁴",
            "5": "⁵",
            "6": "⁶",
            "7": "⁷",
            "8": "⁸",
            "9": "⁹",
        ]

        let superscriptedNumber = number.map { superscriptDigits[$0] ?? String($0) }.joined()
        return superscriptedNumber
    }

    func updateResultText(_ text: String) {
        resultText.text = text
        print("updateResultText called with text: \(text)")
    }

    var presenter: CalculatorPresenterProtocol!

    @IBOutlet var clearButton: UIButton!
    @IBOutlet var removeButton: UIButton!
    @IBOutlet var modButton: UIButton!
    @IBOutlet var pharantessOpenButton: UIButton!
    @IBOutlet var pharantessCloseButton: UIButton!
    @IBOutlet var roundButton: UIButton!
    @IBOutlet var rootButton: UIButton!
    @IBOutlet var factorialButton: UIButton!
    @IBOutlet var piButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var divideButton: UIButton!
    @IBOutlet var equalButton: UIButton!
    @IBOutlet var dotButton: UIButton!
    @IBOutlet var buttonNumber0: UIButton!
    @IBOutlet var buttonNumber1: UIButton!
    @IBOutlet var buttonNumber2: UIButton!
    @IBOutlet var buttonNumber3: UIButton!
    @IBOutlet var buttonNumber4: UIButton!
    @IBOutlet var buttonNumber5: UIButton!
    @IBOutlet var buttonNumber6: UIButton!
    @IBOutlet var buttonNumber7: UIButton!
    @IBOutlet var buttonNumber8: UIButton!
    @IBOutlet var buttonNumber9: UIButton!

    @IBOutlet var descriptionText: UILabel!
    @IBOutlet var resultText: UILabel!

    var realDecriptionText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func textButtonsTapped(_ sender:UIButton) {
        guard let text = sender.titleLabel?.text else {return}
        let newText = text.replacingOccurrences(of: "x", with: "")
        
        appendToDescriptionText(newText)
    }
    
    @IBAction func equalButtonTapped(_ sender:UIButton) {
        presenter.equalButtonTapped()
    }
    @IBAction func clearButtonTapped(_ sender:UIButton) {
        presenter.clearButtonTapped()
    }
    @IBAction func backButtonTapped(_ sender:UIButton) {
        presenter.removeButtonTapped()
    }
    @IBAction func squareButtonTapped(_ sender:UIButton) {
        presenter.roundButtonTapped()
    }

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

@IBDesignable class CircleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}

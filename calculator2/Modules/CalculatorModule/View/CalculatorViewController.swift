//
//  CalculatorViewController.swift
//  calculator2
//
//  Created by Suzan Tekin on 1.12.2023.
//

import UIKit

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
    }

    func removeLastCharacterFromDescriptionText() {
        if var descriptionText = descriptionText.text, !descriptionText.isEmpty {
            descriptionText.removeLast()
            updateDescriptionText(descriptionText)
        }
    }

    func appendToDescriptionText(_ text: String) {
        if var currentText = descriptionText.text {
            currentText += text
            updateDescriptionText(currentText)
        }
    }

    func getDescriptionText() -> String? {
        return descriptionText.text
    }

    func updateDescriptionText(_ text: String) {
        descriptionText.text = text
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget(clearButton, #selector(clearButtonTapped))
        setTarget(removeButton, #selector(removeButtonTapped))
        setTarget(clearButton, #selector(clearButtonTapped))
        setTarget(removeButton, #selector(removeButtonTapped))
        setTarget(modButton, #selector(modButtonTapped))
        setTarget(pharantessOpenButton, #selector(parenthesesOpenButtonTapped))
        setTarget(pharantessCloseButton, #selector(parenthesesCloseButtonTapped))
        setTarget(roundButton, #selector(roundButtonTapped))
        setTarget(rootButton, #selector(rootButtonTapped))
        setTarget(factorialButton, #selector(factorialButtonTapped))
        setTarget(piButton, #selector(piButtonTapped))
        setTarget(plusButton, #selector(plusButtonTapped))
        setTarget(minusButton, #selector(minusButtonTapped))
        setTarget(multiplyButton, #selector(multiplyButtonTapped))
        setTarget(divideButton, #selector(divideButtonTapped))
        setTarget(equalButton, #selector(equalButtonTapped))
        setTarget(dotButton, #selector(dotButtonTapped))
        setTarget(buttonNumber0, #selector(buttonNumber0Tapped))
        setTarget(buttonNumber1, #selector(buttonNumber1Tapped))
        setTarget(buttonNumber2, #selector(buttonNumber2Tapped))
        setTarget(buttonNumber3, #selector(buttonNumber3Tapped))
        setTarget(buttonNumber4, #selector(buttonNumber4Tapped))
        setTarget(buttonNumber5, #selector(buttonNumber5Tapped))
        setTarget(buttonNumber6, #selector(buttonNumber6Tapped))
        setTarget(buttonNumber7, #selector(buttonNumber7Tapped))
        setTarget(buttonNumber8, #selector(buttonNumber8Tapped))
        setTarget(buttonNumber9, #selector(buttonNumber9Tapped))
    }

    func setTarget(_ button: UIButton, _ selector: Selector) {
        button.addTarget(self, action: selector, for: .touchUpInside)
    }

    @objc func clearButtonTapped() {
        presenter.clearButtonTapped()
    }

    @objc func removeButtonTapped() {
        presenter.removeButtonTapped()
    }

    @objc func modButtonTapped() {
        presenter.modButtonTapped()
    }

    @objc func parenthesesOpenButtonTapped() {
        presenter.parenthesesOpenButtonTapped()
    }

    @objc func parenthesesCloseButtonTapped() {
        presenter.parenthesesCloseButtonTapped()
    }

    @objc func roundButtonTapped() {
        presenter.roundButtonTapped()
    }

    @objc func rootButtonTapped() {
        presenter.rootButtonTapped()
    }

    @objc func factorialButtonTapped() {
        presenter.factorialButtonTapped()
    }

    @objc func piButtonTapped() {
        presenter.piButtonTapped()
    }

    @objc func plusButtonTapped() {
        presenter.plusButtonTapped()
    }

    @objc func minusButtonTapped() {
        presenter.minusButtonTapped()
    }

    @objc func multiplyButtonTapped() {
        presenter.multiplyButtonTapped()
    }

    @objc func divideButtonTapped() {
        presenter.divideButtonTapped()
    }

    @objc func equalButtonTapped() {
        presenter.equalButtonTapped()
    }

    @objc func dotButtonTapped() {
        presenter.dotButtonTapped()
    }

    @objc func buttonNumber0Tapped() {
        presenter.buttonNumber0Tapped()
    }

    @objc func buttonNumber1Tapped() {
        presenter.buttonNumber1Tapped()
    }

    @objc func buttonNumber2Tapped() {
        presenter.buttonNumber2Tapped()
    }

    @objc func buttonNumber3Tapped() {
        presenter.buttonNumber3Tapped()
    }

    @objc func buttonNumber4Tapped() {
        presenter.buttonNumber4Tapped()
    }

    @objc func buttonNumber5Tapped() {
        presenter.buttonNumber5Tapped()
    }

    @objc func buttonNumber6Tapped() {
        presenter.buttonNumber6Tapped()
    }

    @objc func buttonNumber7Tapped() {
        presenter.buttonNumber7Tapped()
    }

    @objc func buttonNumber8Tapped() {
        presenter.buttonNumber8Tapped()
    }

    @objc func buttonNumber9Tapped() {
        presenter.buttonNumber9Tapped()
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

// button yuvarlaklığı
@IBDesignable class CircleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}

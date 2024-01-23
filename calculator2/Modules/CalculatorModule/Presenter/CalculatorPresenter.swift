//
//  CalculatorPresenter.swift
//  calculator2
//
//  Created by Suzan Tekin on 1.12.2023.
//

import Foundation

protocol CalculatorPresenterProtocol: AnyObject {
    func clearButtonTapped()
    func removeButtonTapped()
    func modButtonTapped()
    func parenthesesOpenButtonTapped()
    func parenthesesCloseButtonTapped()
    func roundButtonTapped()
    func rootButtonTapped()
    func factorialButtonTapped()
    func piButtonTapped()
    func plusButtonTapped()
    func minusButtonTapped()
    func multiplyButtonTapped()
    func divideButtonTapped()
    func equalButtonTapped()
    func dotButtonTapped()
    func buttonNumber0Tapped()
    func buttonNumber1Tapped()
    func buttonNumber2Tapped()
    func buttonNumber3Tapped()
    func buttonNumber4Tapped()
    func buttonNumber5Tapped()
    func buttonNumber6Tapped()
    func buttonNumber7Tapped()
    func buttonNumber8Tapped()
    func buttonNumber9Tapped()
}

class CalculatorPresenter: CalculatorPresenterProtocol {
    
    func clearButtonTapped() {
        view?.updateDescriptionText("")
        view?.updateResultText("0")
    }

    func removeButtonTapped() {
        if var descriptionText = view?.getDescriptionText(), !descriptionText.isEmpty {
            descriptionText.removeLast()
            view?.updateDescriptionText(descriptionText)
            view?.updateResultText("0") // Result'ı sıfırla
        }
        /*
         if var descriptionText = view?.getDescriptionText(), !descriptionText.isEmpty {
             descriptionText.removeLast()
             view?.updateDescriptionText(descriptionText)
         }
          */
    }

    func modButtonTapped() {
        appendToDescriptionText("%")
    }

    func parenthesesOpenButtonTapped() {
        appendToDescriptionText("(")
    }

    func parenthesesCloseButtonTapped() {
        appendToDescriptionText(")")
    }

    func roundButtonTapped() {
        appendToDescriptionText("^")
    }

    func rootButtonTapped() {
        appendToDescriptionText("kök")
    }

    func factorialButtonTapped() {
        appendToDescriptionText("!")
    }

    func piButtonTapped() {
        appendToDescriptionText("pi")
    }

    func plusButtonTapped() {
        appendToDescriptionText("+")
    }

    func minusButtonTapped() {
        appendToDescriptionText("-")
    }

    func multiplyButtonTapped() {
        appendToDescriptionText("*")
    }

    func divideButtonTapped() {
        appendToDescriptionText("/")
    }

    func equalButtonTapped() {
        if let result = interactor.evaluateMathExpression(view?.getDescriptionText() ?? "") {
            view?.updateResultText(String(result))
        }
    }

    func dotButtonTapped() {
        appendToDescriptionText(".")
    }

    func buttonNumber0Tapped() {
        appendToDescriptionText("0")
    }

    func buttonNumber1Tapped() {
        appendToDescriptionText("1")
    }

    func buttonNumber2Tapped() {
        appendToDescriptionText("2")
    }

    func buttonNumber3Tapped() {
        appendToDescriptionText("3")
    }

    func buttonNumber4Tapped() {
        appendToDescriptionText("4")
    }

    func buttonNumber5Tapped() {
        appendToDescriptionText("5")
    }

    func buttonNumber6Tapped() {
        appendToDescriptionText("6")
    }

    func buttonNumber7Tapped() {
        appendToDescriptionText("7")
    }

    func buttonNumber8Tapped() {
        appendToDescriptionText("8")
    }

    func buttonNumber9Tapped() {
        appendToDescriptionText("9")
    }

    private func appendToDescriptionText(_ text: String) {
        if var currentText = view?.getDescriptionText() {
            currentText += text
            view?.updateDescriptionText(currentText)
        }
    }

    weak var view: CalculatorViewProtocol?
    var interactor: CalculatorInteractorProtocol!
    var router: CalculatorRouterProtocol!

    init(view: CalculatorViewProtocol) {
        self.view = view
        interactor = CalculatorInteractor(presenter: self)
    }
}

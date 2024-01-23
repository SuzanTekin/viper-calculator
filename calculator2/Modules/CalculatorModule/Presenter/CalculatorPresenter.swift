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
    func roundButtonTapped()
    func equalButtonTapped()
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
            view?.updateResultText("0")
        }
    }

    func roundButtonTapped() {
        if var currentText = view?.getDescriptionText() {
            currentText += "^"
            view?.updateDescriptionText(currentText)
        }
    }
    
    func equalButtonTapped() {
        if let result = interactor.evaluateMathExpression(view?.getDescriptionText() ?? "0")?.string {
            view?.updateResultText(result)
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

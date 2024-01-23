//
//  CalculatorRouter.swift
//  calculator2
//
//  Created by Suzan Tekin on 1.12.2023.
//

import Foundation
import UIKit

protocol CalculatorRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class CalculatorRouter: CalculatorRouterProtocol {
    weak var viewController: UIViewController?

    class func createModule() -> UIViewController {
        let view = CalculatorViewController()
        let presenter = CalculatorPresenter(view: view)
        let interactor = CalculatorInteractor(presenter: presenter)
        let router = CalculatorRouter()

        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router

        router.viewController = view

        return view
    }

}

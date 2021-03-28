//
//  LoginViewModel.swift
//  MultiChoiceApp
//
//  Created by Shamith Ramdhani on 2021/03/23.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func proceedToNextScreen()
    func showLoginError(message: String)
}

class LoginViewModel {
    
    private weak var delegate: LoginViewModelDelegate?
    private var loginService: LoginServiceContract?
    private(set) var dataTransportModel = ApplicationTransportModel()
    
    init(delegate: LoginViewModelDelegate,
         loginService: LoginServiceContract) {
        self.delegate = delegate
        self.loginService = loginService
    }
    
    func performLogin() {
        let loginRequestModel = LoginRequestModel(username: "user", password: "1234")
        loginService?.performLogin(requestModel: loginRequestModel,
                                   successBlock: { [weak self] (loginResponseModel) in
                                    self?.dataTransportModel.loginDetails = loginResponseModel
                                    DispatchQueue.main.async {
                                        self?.delegate?.proceedToNextScreen()
                                    }
                                   },
                                   failureBlock: { [weak self] (error) in
                                    DispatchQueue.main.async {
                                        self?.delegate?.showLoginError(message: error)
                                    }
                                   })
    }
}

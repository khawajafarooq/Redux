//
//  ViewController.swift
//  LoginRedux
//
//  Created by GIB on 7/28/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import UIKit
import ReSwift

class LoginViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var usernameErrorLabel: UILabel!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var passwordErrorLabel: UILabel!
    @IBOutlet weak private var loginButton: UIButton!
    @IBOutlet weak private var loginErrorLabel: UILabel!
    
    // MARK:- Properties
    let mainStore = Store<LoginState>(
        reducer: loginReducer,
        state: nil
    )
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { state in
            state.select(LoginStateTranslator.init)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    // MARK:- Event Handlers
    @IBAction func loginTapped(_ sender: AnyObject) {
        
        if usernameTextField.text == "Farooq",
            passwordTextField.text == "abcd1234" {
            mainStore.dispatch(LoginAction.loginPress(.success(true)))
        } else {
            mainStore.dispatch(LoginAction.loginPress(.failure(APIError.requestFailed)))
        }
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var text = textField.text! + string
        
        if string.isEmpty {
            text = String(text.removeLast())
        }
        
        if textField == usernameTextField {
            
            if text.count <= 5 {
                mainStore.dispatch(LoginAction.typingUsername(.invalid(.invalid("Username"))))
            } else {
                mainStore.dispatch(LoginAction.typingUsername(.valid))
            }
        } else if textField == passwordTextField {
            
            if text.count <= 7 {
                mainStore.dispatch(LoginAction.typingPassword(.invalid(.invalid("Password"))))
            } else {
                mainStore.dispatch(LoginAction.typingPassword(.valid))
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension LoginViewController: StoreSubscriber {
    func newState(state: LoginStateTranslator) {
        // when the state changes, the UI is updated to reflect the current state
        usernameErrorLabel.isHidden = state.usernameErrorHidden
        usernameErrorLabel.text = state.usernameErrorText
        passwordErrorLabel.isHidden = state.passwordErrorHidden
        passwordErrorLabel.text = state.passwordErrorText
        loginButton.isEnabled = state.loginButtonEnable
        loginErrorLabel.text = state.loginErrorText
    }
}

extension String {
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
}

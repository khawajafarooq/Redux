//
//  LoginViewControlerTests.swift
//  LoginReduxTests
//
//  Created by GIB on 7/29/18.
//  Copyright © 2018 Xmen. All rights reserved.
//

import XCTest
@testable import LoginRedux

class LoginViewControlerTests: XCTestCase {

    var loginVC: LoginViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        // loading the view in hierarchy
        _ = loginVC.view
        loginVC.viewWillAppear(true)
    }

    override func tearDown() {
        
        loginVC = nil
    }

    func testErrorInitialState() {

        XCTAssertEqual(loginVC.usernameErrorLabel.isHidden, true)
        XCTAssertEqual(loginVC.passwordErrorLabel.isHidden, true)
        XCTAssertEqual(loginVC.loginErrorLabel.isHidden, true)
    }

    func testUsernameValidState() {
        loginVC.usernameTextField.text = "farooq"
        XCTAssertEqual(loginVC.usernameErrorLabel.isHidden, true)
    }
    
    func testUsernameInvalidState() {
        loginVC.usernameTextField.text = "abc"
        let len = (loginVC.usernameTextField.text?.count)!-1
        _ = loginVC.textField(loginVC.usernameTextField, shouldChangeCharactersIn: NSMakeRange(0, len), replacementString:"d")
        XCTAssertEqual(loginVC.usernameErrorLabel.isHidden, false)
    }
    
    func testPasswordValidState() {
        loginVC.passwordTextField.text = "abdcefgh"
        XCTAssertEqual(loginVC.passwordErrorLabel.isHidden, true)
    }
    
    func testPasswordInvalidState() {
        loginVC.passwordTextField.text = "abcdef"
        let len = (loginVC.passwordTextField.text?.count)!-1
        _ = loginVC.textField(loginVC.passwordTextField, shouldChangeCharactersIn: NSMakeRange(0, len), replacementString:"g")
        XCTAssertEqual(loginVC.passwordErrorLabel.isHidden, false)
    }
    
    func testLoginSuccessState() {
        loginVC.usernameTextField.text = "Farooq"
        loginVC.passwordTextField.text = "abcd1234"
        loginVC.loginTapped(self)
        
        XCTAssertEqual(loginVC.loginErrorLabel.isHidden, true)
        XCTAssertEqual(loginVC.loginButton.isEnabled, false)
    }
    
    func testLoginFailureState() {
        loginVC.usernameTextField.text = "farooq"
        loginVC.passwordTextField.text = "Sabcd1234"
        loginVC.loginTapped(self)
        
        XCTAssertEqual(loginVC.loginErrorLabel.isHidden, false)
        XCTAssertEqual(loginVC.loginButton.isEnabled, true)
    }
}

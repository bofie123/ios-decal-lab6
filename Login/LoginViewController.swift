//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    let loginBtn = UIButton(frame: CGRect(x: 0.25 * UIScreen.main.bounds.width, y: 100, width: 150, height: 40))
    let loginViewControllerLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 0.8 * UIScreen.main.bounds.width, height: 200))
    let accountTextField = UITextField(frame: CGRect(x: 10, y: 30, width: 0.9 * UIScreen.main.bounds.width, height: 20))
    let passwordTextField = UITextField(frame: CGRect(x: 10, y: 70, width: 0.9 * UIScreen.main.bounds.width, height: 20))
    let loginUIView = UIView(frame: CGRect(x: 0.05 * UIScreen.main.bounds.width, y: 100, width: 0.9 * UIScreen.main.bounds.width, height: 150))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = Constants.backgroundColor
        loginBtn.layer.cornerRadius = 8
        loginBtn.addTarget(self, action:#selector(loginButtonClicked), for:.touchUpInside)
        
        loginUIView.center = view.center
        loginUIView.backgroundColor = .white
        
        loginViewControllerLabel.text = "Login View Controller"
        loginViewControllerLabel.numberOfLines = 0
        loginViewControllerLabel.textColor = .white
        loginViewControllerLabel.font = UIFont (name: "Helvetica Neue", size: 40)
        
        accountTextField.placeholder = "berkeley.edu account"
        
        passwordTextField.placeholder = "Password"
        
        view.addSubview(loginViewControllerLabel)
        view.addSubview(loginUIView)
        loginUIView.layer.cornerRadius = 8
        loginUIView.addSubview(loginBtn)
        loginUIView.addSubview(accountTextField)
        loginUIView.addSubview(passwordTextField)
        
        // TODO: layout your views using frames or AutoLayout
    }
    
    // TODO: create an IBAction for your login button

    @IBAction func loginButtonClicked(sender:UIButton!) {
        authenticateUser(username: accountTextField.text, password: passwordTextField.text)
    }

    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}

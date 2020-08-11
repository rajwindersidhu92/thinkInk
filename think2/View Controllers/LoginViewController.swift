//
//  LoginViewController.swift
//  think2
//
//  Created by Rajwinder Kaur on 2020-08-06.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!
   @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
     @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpElements()
        }
        
        func setUpElements() {
            
            // Hide the error label
            errorLabel.alpha = 0
            
        }
        
        
    @IBAction func onSignIn(_ sender: Any) {
          // Validate the fields
                      let error = validateFields()
                      
                      if error != nil {
                          
                          // There's something wrong with the fields, show error message
                        self.showError(error!)
                      }
                      else {
                        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
                        // Signing in the user
                        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                       
                        if error != nil {
                           // Couldn't sign in
                            self.showError("Invalid email or password. Please try again")
                           
                       }
                       else {
                           let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                           
                           self.view.window?.rootViewController = homeViewController
                           self.view.window?.makeKeyAndVisible()
                       }
                   }
        }
    }
     // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
       func validateFields() -> String? {
           
           // Check that all fields are filled in
           if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               
               return "Please fill in all fields."
           }
           
           // Check if the email is valid
           let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if Utilities.isEmailValid(cleanedEmail) == false {
               // email isn't valid
               return "Please enter a Valid email ID."
           }
           
           return nil
       }
     func showError(_ message:String) {
                   print("Something went wrong \(message)")
                   errorLabel.text = message
                   errorLabel.alpha = 1
     }

}

//
//  SignUpViewController.swift
//  think2
//
//  Created by Rajwinder Kaur on 2020-08-10.
//  Copyright © 2020 Udhay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
            
    @IBOutlet weak var emailTextField: UITextField!
            
    @IBOutlet weak var passwordTextField: UITextField!
            
    @IBOutlet weak var signUpButton: UIButton!
            
            @IBOutlet weak var errorLabel: UILabel!
            
            
            override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                setUpElements()
            }
            
            func setUpElements() {
            
                // Hide the error label
                errorLabel.alpha = 0
            
            }
            
            // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
            func validateFields() -> String? {
                
                // Check that all fields are filled in
                if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  ||
                    emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    
                    return "Please fill in all fields."
                }
                
                //Email Validation
                if Utilities.isEmailValid(emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false {
                    // Email isn't valid
                    return "Please Enter valid email Address"
                }
                
                // Check if the password is secure
                let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if Utilities.isPasswordValid(cleanedPassword) == false {
                    // Password isn't secure enough
                    return "Please make sure your password is at least 8 characters, contains a special character and a number."
                }
                
                return nil
            }
            

            @IBAction func signUpTapped(_ sender: Any) {
               print("here")
                // Validate the fields
                let error = validateFields()
                
                if error != nil {
                    
                    // There's something wrong with the fields, show error message
                    showError(error!)
                }
                else {
                    
                    // Create cleaned versions of the data
                    let userName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // Create the user
                    Auth.auth().createUser(withEmail: email, password: password ) { (result, err)
                        in
                        
                        // Check for errors
                        if err != nil {
                            
                            // There was an error creating the user
                            self.showError("Error creating user")
                        }
                        else {
                            
                            // User was created successfully, now store the first name and last name
                            let db = Firestore.firestore()
                            
                            db.collection("users").addDocument(data: ["username":userName, "uid": result!.user.uid ]) { (error) in
                                
                                if error != nil {
                                    // Show error message
                                    self.showError("Error saving user data")
                                
                                }
                            }
                            
                            // Transition to the home screen
                            self.transitionToHome()
                        }
                        
                    }
            
                }
            } //end signInTapped
            
            func showError(_ message:String) {
                print("Something went wrong \(message)")
                errorLabel.text = message
                errorLabel.alpha = 1
            }
            
    
            func transitionToHome() {
                
                let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                
                view.window?.rootViewController = homeViewController
                view.window?.makeKeyAndVisible()
                
            }
            
        }

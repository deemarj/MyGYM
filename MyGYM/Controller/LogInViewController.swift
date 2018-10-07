//  LogInViewController.swift
//  MyGYM
//
//  Created by Aseel Mohimeed on 11/01/1440 AH.
//  Copyright © 1440 Aseel Mohimeed. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        
       // logInPressed.layer.cornerRadius = 10
        // logInPressed.clipsToBounds = true
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print (error!)
                
                self.view.endEditing(true)
                
                if (self.emailTextfield.text?.isEmpty)! || (self.passwordTextfield.text?.isEmpty)!
                {
                    let alert = UIAlertController(
                        title: "Invalid Login!",
                        message: "Please fill your e-mail and password",
                        preferredStyle: UIAlertControllerStyle.alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // do something when user press OK button, like deleting text in both fields or do nothing
                    }
                    
                    alert.addAction(OKAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                else {
                // need to add handel exception when invalid email or password
                    //MBProgressHUD.dismiss()
                    print("error")
                    let alertController = UIAlertController(title: "Invalid Login!", message: "Incorrect credentials", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    print(error?.localizedDescription as Any)
                }
                
            } else {
               let userID = Auth.auth().currentUser?.uid
               let ref = Database.database().reference().root
                ref.child("users").child(userID!).observeSingleEvent(of: .value, with: {     (snapshot) in
                    
                    let snapDict = snapshot.value as? NSDictionary
                    
                    let role = snapDict?["Role"] as? String ?? ""
                    print(role)
                        
                        if (role == "Member") {
                          print ("Log in succssful! Hi member")
                          self.performSegue(withIdentifier: "goToWelcomeAgain", sender: self)}
                        else if (role == "Trainer") {
                            print ("Log in succssful! Hi Trainer")
                            self.performSegue(withIdentifier: "goToTrainerHomePage", sender: self)}
                 else   if (role == "Admin") {
                        print ("Log in succssful! Hi Admin")
                        self.performSegue(withIdentifier: "goToAdminHomePage", sender: self)}
                   else {
                    print ("Sorry you are not member")}
                })

                }
            }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToWelcome", sender: self)
    }
    
    // The 2 functions here to hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
}
    


//
//  RegisterViewController.swift
//  MyGYM
//
//  Created by Aseel Mohimeed on 11/01/1440 AH.
//  Copyright © 1440 Aseel Mohimeed. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    
    //Pre-linked IBOutlets
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var membershipID: UITextField!
    @IBOutlet weak var nameTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        //TODO: Set up a new user on our Firbase database
        guard let email = emailTextfield.text, !email.isEmpty else { print("Email is empty"); return }
        guard let password = passwordTextfield.text, !password.isEmpty else { print("Pssword is empty"); return }
        guard let name = nameTextFeild.text, !name.isEmpty else { print("Name is empty"); return }
        guard let membershipId = membershipID.text, !membershipId.isEmpty else { print("Membership ID is empty"); return }
        
        let ref = Database.database().reference().root
        
        if email != "" && password != "" && name != "" {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in if error != nil{
                print(error!)
            } else {
                //success
                print ("Registration Successful!")
                let userID = Auth.auth().currentUser!.uid
                
                ref.child("users").child(userID).setValue(["Name": name, "Email": email, "Role": "Member", "MembershipID": membershipId])
                self.performSegue(withIdentifier: "goToWelcomeAgain", sender: self)
                
                }
            })
        }
        
    }
    

}

//
//  InBodyViewController.swift
//  MyGYM
//
//  Created by Deema on 9/22/18.
//  Copyright © 2018 Deema. All rights reserved.
//

import UIKit
import Firebase

class InBodyViewController: UIViewController {


    @IBOutlet weak var dateViewed: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bookLabel: UILabel!
    
    var refInBodies = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookLabel.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func bookPressed(_ sender: Any) {
        dateViewed.text = "\(datePicker.date)"
        
        let key = refInBodies.childByAutoId().key
        let userID = Auth.auth().currentUser!.uid
        let inBodyDate = ["id":key , "InbodyDate": "\(datePicker.date)" as String , "userID" : userID as String ]
        refInBodies.child(key!).setValue(inBodyDate)
        
        self.bookLabel.text = "Your InBody reserved Successfully! "
        self.bookLabel.isHidden = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.bookLabel.isHidden = true
            
        }
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMemberHomePage", sender: self)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMemberHomePage", sender: self)
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch {
            print("error: there was a problem logging out")
        }
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


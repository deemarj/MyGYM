//
//  ProfileViewController.swift
//  MyGYM
//
//  Created by  Deema on 13/01/1440 AH.
//  Copyright © 1440 Aseel Mohimeed. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var MembershipID: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!

    
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageProfile.image = UIImage( named: "userDefault.png")
        name.text = "Deema Alrajeh"
        MembershipID.text = "1234"

   //     weeklyPlan.text = "Week 1: \n\n Sunday: \n Monday: \n Tuesday: \n Wednesday \n Thursday: \n Friday \n Saturday: "
        email.text = "Deema@gmail.com"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateProfirePressed(_ sender: Any) {
    }
    
    
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMemberHomePage", sender: self)
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
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

//
//  AdminWeeklyScheduleViewController.swift
//  MyGYM
//
//  Created by  Deema on 17/01/1440 AH.
//  Copyright © 1440 Aseel Mohimeed. All rights reserved.
//

import UIKit
import Firebase

class AdminWeeklyScheduleViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
 
    
    //database referance
    var classesRef:  DatabaseReference!

   
    @IBOutlet weak var classTime: UITextField!
    @IBOutlet weak var className: UITextField!
    //@IBOutlet weak var classCapacity: UITextField!
    @IBOutlet weak var lableMessage: UILabel!
    
    @IBOutlet weak var classesTable: UITableView!
    //Array to store all classes
    var classesList = [ClassModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AdminWeeklyScheduleTableViewCell
        
        let class1: ClassModel
        class1 = classesList[indexPath.row]
        
        cell.classNameLable.text = class1.name
        cell.classTimeLable.text = class1.time
     //   cell.classCapacityLable.text = class1.capacity
        
        return cell
    }
    
    @IBAction func addClassPressed(_ sender: Any) {
        //newwwwwww------------------------------------
        if (self.classTime.text?.isEmpty)! || (self.className.text?.isEmpty)!
        {
            lableMessage.text = "Class is not Added! fill the required information"
        } //end newwwwwwwww--------------------------
        
        else {
            addClass() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        classesRef = Database.database().reference().child("classes");
        classesRef.observe(DataEventType.value, with: {(snapshot) in
            //if the reference have some values
            if snapshot.childrenCount>0{
                //clearing the list of classes
              self.classesList.removeAll()
                //iterating through all the values
                for classes in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let classObject = classes.value as? [String: AnyObject]
                    let classtName  = classObject?["className"]
                    let classId  = classObject?["id"]
                    let classTime = classObject?["classDate"]
                   // let classCapacity = classObject?["classCapacity"]

                    //creating class object with model and fetched values
                    let Class = ClassModel(id: classId as! String?, name: classtName as! String?, time: classTime as! String?)
                    
                    //appending it to list
                    self.classesList.append(Class)
                }
                //reloading the tableview
                self.classesTable.reloadData()
            }
        })
    }
    
    func addClass(){
        //give a uniqe id to a class
        let classID = classesRef.childByAutoId().key
        //creating a class based on the info passed by the admin
        let class1 = ["id":classID,
                       "className": className.text! as String,
                       "classDate": classTime.text! as String]
        classesRef.child(classID!).setValue(class1)
        
      
        lableMessage.text = "Class Added!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToAdminHomePage", sender: self)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToAdminHomePage", sender: self)
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

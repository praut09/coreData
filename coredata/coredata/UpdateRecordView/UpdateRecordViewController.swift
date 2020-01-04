//
//  UodateRecordViewController.swift
//  coredataProject
//
//  Created by sachin shinde on 04/01/20.
//  Copyright © 2020 sachin shinde. All rights reserved.
//

import UIKit
import CoreData
var getrecord = NSManagedObject()
class UpdateRecordViewController: UIViewController {

  
    
    @IBOutlet var passwordUpdate: UITextField!
    @IBOutlet var usernameUpdate: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var pred = NSPredicate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameUpdate.text = getrecord.value(forKey: "username") as? String
        passwordUpdate.text = getrecord.value(forKey: "password") as? String
        pred = NSPredicate(format: "password =%@", passwordUpdate.text!)
    
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnUpdate(_ sender: UIButton) {
        let context = appDelegate.persistentContainer.viewContext
        let entitidec = NSEntityDescription.entity(forEntityName: "Login", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        request.entity = entitidec
        request.predicate = pred
        do {
        let result = try context.fetch(request)
        if result.count > 0 {
        let manage = result[0] as! NSManagedObject
        manage.setValue(usernameUpdate.text!, forKey: "username")
        manage.setValue(passwordUpdate.text!, forKey: "password")

        try context.save()
         self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)

        }
        else{
        print("Record Not Found")
        }
        } catch {
        }
    
    }
   

}

//
//  ViewController.swift
//  coredata
//
//  Created by sachin shinde on 04/01/20.
//  Copyright © 2020 sachin shinde. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //MARK:- ObjectLifeCycle
    @IBOutlet var txt_username: UITextField!
    @IBOutlet var txt_password: UITextField!
    @IBOutlet var btn_login: UIButton!
    let nscontext = ((UIApplication.shared.delegate) as!
    AppDelegate).persistentContainer.viewContext
    
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK:- Button Actions
    @IBAction func btn_loginAction(_ sender: UIButton) {
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Login",
        into: nscontext)
        entity.setValue(txt_username.text, forKey:"username") // email is a Your Entity Key
        entity.setValue(txt_password.text, forKey: "password")
        do
        {
        try nscontext.save()
        txt_username.text = ""
        txt_password.text = ""

        }
        catch
        {

        }
        print("Record Inserted")
        self.navigationController?.popViewController(animated: true)
        
    }
}



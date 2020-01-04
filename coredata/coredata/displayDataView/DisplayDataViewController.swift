//
//  DisplayDataViewController.swift
//  coredataProject
//
//  Created by sachin shinde on 04/01/20.
//  Copyright © 2020 sachin shinde. All rights reserved.
//

import UIKit
import CoreData
class DisplayDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  
    @IBOutlet var tableViewDisplay: UITableView!
    var window: UIWindow?
    var item :[Any] = []
    var dict = NSMutableDictionary()
    let appdelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.appendData()
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.appendData()
        tableViewDisplay.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell
        let dic = item[indexPath.row] as! NSManagedObject
        cell.lblName?.text = dic.value(forKey: "username" ) as? String
        
        cell.lblPassword?.text = dic.value(forKey: "password" ) as? String
        return cell
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
    return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {

    // Edit Button
    let editAction = UITableViewRowAction(style: .default, title: "Edit",
    handler: { (action, indexPath) in
    let temp = self.item[indexPath.row] as! NSManagedObject
        let updateVC = self.storyboard?.instantiateViewController(identifier: "UpdateRecordViewController") as! UpdateRecordViewController
        getrecord = temp
    self.navigationController?.pushViewController(updateVC, animated: true)
    })
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
        let temp = self.item[indexPath.row] as! NSManagedObject
        let userNAME = temp.value(forKey: "username")
        let context = self.appdelegate.persistentContainer.viewContext
        let entitydec = NSEntityDescription.entity(forEntityName: "Login", in:
        context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        request.entity = entitydec
        let pred = NSPredicate(format: "username = %@", userNAME as! CVarArg)
        request.predicate = pred
        do
        {
        let result = try context.fetch(request)
        if result.count > 0
        {
        let manage = result[0] as! NSManagedObject
        context.delete(manage)
        try context.save()
        print("Record Deleted")
        }
        else
        {
        print("Record Not Found")
        }
        }
        catch {}
        self.item.remove(at: indexPath.row)
        self.tableViewDisplay.deleteRows(at: [indexPath], with: .middle)
        self.tableViewDisplay.reloadData()

        })

        return [deleteAction, editAction]
        }


  
    
    func appendData()
    {
        let context = appdelegate.persistentContainer.viewContext
        var locations = [Login]() // Login is your Entity name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        fetchRequest.returnsObjectsAsFaults = false
        locations = try! context.fetch(fetchRequest) as! [Login]
        item.removeAll()
        
        for location in locations {
        item.append(location) // item is your array
        }
    }

}

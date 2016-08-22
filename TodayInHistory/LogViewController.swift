//
//  LogViewController.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/19/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit
import CoreData

class LogViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationTextLabel: UILabel!
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        // instantiate the register view controller and push it on the current view
        let regView = self.storyboard?.instantiateViewControllerWithIdentifier("RegView") as! RegViewController
        self.navigationController?.pushViewController(regView, animated: true)
    }
    
    @IBAction func continueButtonPressed(sender: UIButton) {
        // instantiate main view and fetch the one user to see if he/she's in Core Data
        let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainView") as! MainViewController
        
        let email = emailTextField.text
        let pass = passwordTextField.text
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        fetchRequest.predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: [NSPredicate(format: "email = %@", email!), NSPredicate(format: "password = %@", pass!)])
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
//            print(result)
//            print(result[0].email!)
            if result.count > 0 {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setValue(result[0].email!, forKey: "CurrentEmail")
                defaults.setValue(result[0].firstName!, forKey: "CurrentFirst")
                defaults.setValue(result[0].lastName!, forKey: "CurrentLast")
                defaults.setValue(result[0].password!, forKey: "CurrentPassword")
                
                defaults.synchronize()
                self.navigationController?.pushViewController(mainView, animated: true)
            }
            else {
                // display error
                validationTextLabel.text = "Failed to Login."
            }
        }
        catch {
            print("\(error)")
        }
        //        let currentUser = NSUserDefaults.valueForKey("CurrentUser")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        validationTextLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

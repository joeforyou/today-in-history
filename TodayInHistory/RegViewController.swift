//
//  RegViewController.swift
//  TodayInHistory
//
//  Created by Joseph Kleinschmidt on 8/19/16.
//  Copyright © 2016 Joseph Kleinschmidt. All rights reserved.
//

import UIKit
import CoreData

class RegViewController: UIViewController {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var validationTextLabel: UILabel!
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        if passwordTextField.text == confirmPassTextField.text{
            
            let fetchRequest = NSFetchRequest(entityName: "User")
            let email = emailTextField.text
            fetchRequest.predicate = NSPredicate(format: "email = %@", email!)
            do {
                let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
                if result.count == 0{
                    let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("MainView") as! MainViewController
                    mainView.saveNewUser(firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
                    self.navigationController?.popViewControllerAnimated(true)
                }
                else {
                    // display error
                    validationTextLabel.text = "Failed to Register. Email already registered."
                }
            }
            catch {
                print("\(error)")
            }
        }
        else {
            // display error message
            validationTextLabel.text = "Password fields must match."
        }
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
    

}

//
//  ViewController.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 3/15/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //UI Elements
    @IBOutlet weak var NumberOfPlayersLabel: UILabel!
    @IBOutlet weak var stepperButtons: UIStepper!
    
    //Class Variables
    var maxPlayers = 0  //Total number of players set by user
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set stepper values
        stepperButtons.wraps = true
        stepperButtons.autorepeat = true
        stepperButtons.maximumValue = 20
        stepperButtons.minimumValue = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //handles stepper increment and decrement
    @IBAction func stepperValueChanged(sender: UIStepper) {
        //update number of players for user to see
        NumberOfPlayersLabel.text = Int(sender.value).description
    }
    
    //actions handled before segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CreatePlayerSegue" {
            if let destination = segue.destinationViewController as? CreatePlayerViewController {
                //pass the total number of players set by user to create player screen
                destination.maxPlayersSet = maxPlayers
                
            }
        }
    }

    @IBAction func BalancedTeams(sender: AnyObject) {
        //get total number of players set by user
        maxPlayers = Int(NumberOfPlayersLabel.text!)!
        performSegueWithIdentifier("CreatePlayerSegue", sender: sender)
    }

    @IBAction func QuickTeams(sender: UIButton) {
        //get total number of players set by user
        maxPlayers = Int(NumberOfPlayersLabel.text!)!
        performSegueWithIdentifier("CreatePlayerSegue", sender: sender)
    }
    
    
}


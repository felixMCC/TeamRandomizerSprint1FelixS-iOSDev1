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
    @IBOutlet weak var numberOfTeamsLabel: UILabel!
    @IBOutlet weak var stepperButtons: UIStepper!
    @IBOutlet weak var numberOfTeamsStepperButtons: UIStepper!
    
    //Class Variables
    var maxPlayers = 0                  //Total number of players set by user
    var numberOfTeams = 0               //Total number of players set by user
    var isRated : Bool = false       //Flag for using player rating system

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set number of players stepper values
        stepperButtons.wraps = true
        stepperButtons.autorepeat = true
        stepperButtons.maximumValue = 20
        stepperButtons.minimumValue = 1
        
        //set number of teams stepper values
        numberOfTeamsStepperButtons.wraps = true
        numberOfTeamsStepperButtons.autorepeat = true
        numberOfTeamsStepperButtons.maximumValue = 20
        numberOfTeamsStepperButtons.minimumValue = 1
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
    
    @IBAction func teamStepperValueChanged(sender: UIStepper) {
        //update number of teams for user to see
        numberOfTeamsLabel.text = Int(sender.value).description
    }
    //actions handled before segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CreatePlayerSegue" {
            if let destination = segue.destinationViewController as? CreatePlayerViewController {
                //set flag for rating system
                destination.isRatedPlayer = isRated
                //pass the total number of players set by user to create player screen
                destination.maxPlayersSet = maxPlayers
                //pass number of teams set by user to the create player screen
                destination.numberOfTeamsToCreate = numberOfTeams
            }
        }
    }

    @IBAction func BalancedTeams(sender: AnyObject) {
        //set flag to indicate no rating will be used
        isRated = false
        //get total number of players set by user
        maxPlayers = Int(NumberOfPlayersLabel.text!)!
        //get number of teams set by user
        numberOfTeams = Int(numberOfTeamsLabel.text!)!
        performSegueWithIdentifier("CreatePlayerSegue", sender: sender)
    }

    @IBAction func QuickTeams(sender: UIButton) {
        //set flag to indicate no rating will be used
        isRated = false
        //get total number of players set by user
        maxPlayers = Int(NumberOfPlayersLabel.text!)!
        //get number of teams set by user
        numberOfTeams = Int(numberOfTeamsLabel.text!)!
        performSegueWithIdentifier("CreatePlayerSegue", sender: sender)
    }
    
    
}


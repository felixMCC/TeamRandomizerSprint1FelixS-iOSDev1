//
//  CreatePlayerViewController.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 3/16/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import UIKit

class CreatePlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //TODO: Create a linked list somewhere?
    //sorting algorithms : Sort by name or by skill level
    
    //UI Elements
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerRatingButton1: UIButton!
    @IBOutlet weak var playerRatingButton2: UIButton!
    @IBOutlet weak var playerRatingButton3: UIButton!
    @IBOutlet weak var playerRatingButton4: UIButton!
    @IBOutlet weak var playerRatingButton5: UIButton!
    @IBOutlet weak var nextPlayerButton: UIButton!  //creates next player
    var starButtonArray = [UIButton!]()
    @IBOutlet weak var playerCountLabel: UILabel!   //how many players have been created
    @IBOutlet weak var playerCreatedLabel: UILabel! //"Players Created:" message
    @IBOutlet weak var diagonalLineLabel: UILabel!  //"/"
    @IBOutlet weak var playerMaxLabel: UILabel!     //max players set by user
    @IBOutlet weak var uiSkillLevelLabel: UILabel!  //"Skill Level"
    
    @IBOutlet weak var firstViewTableView: UITableView!
    
    //UI Images
    let starImage: UIImage = UIImage(named: "star.png")!
    let starGrayImage: UIImage = UIImage(named: "starGray.png")!
    
    //Class Variables
    var playerArray : [Player] = [Player]()         //array of player objects
    var playerName : String = ""                    //player name
    var playerRating : Int = 0                      //player rating (1-5)
    var maxPlayersSet : Int = 0                     //max set by user
    var numberOfTeamsToCreate : Int = 0             //number of teams chosen by user
    let simpleTableIdentifier = "SimpleTable"
    var isRatedPlayer : Bool = false                //flag for using rating system or not
    
    
    override func viewWillAppear(animated: Bool) {
        //set visibility for players created labels
        playerCountLabel.hidden = true
        playerCreatedLabel.hidden = true
        diagonalLineLabel.hidden = true
        playerMaxLabel.hidden = true
        playerMaxLabel.text = String(maxPlayersSet) //set total number of players label
        
        //Handle if chosen method is with ratings or not
        if isRatedPlayer == false {
            //hide UI label
            uiSkillLevelLabel.hidden = true
            //dissable all buttons for rating
            playerRatingButton1.enabled = false
            playerRatingButton2.enabled = false
            playerRatingButton3.enabled = false
            playerRatingButton4.enabled = false
            playerRatingButton5.enabled = false
            //hide all rating buttons
            playerRatingButton1.hidden = true
            playerRatingButton2.hidden = true
            playerRatingButton3.hidden = true
            playerRatingButton4.hidden = true
            playerRatingButton5.hidden = true
            
        }else {
            //hide UI label
            uiSkillLevelLabel.hidden = false
            //dissable all buttons for rating
            playerRatingButton1.enabled = true
            playerRatingButton2.enabled = true
            playerRatingButton3.enabled = true
            playerRatingButton4.enabled = true
            playerRatingButton5.enabled = true
            //hide all rating buttons
            playerRatingButton1.hidden = false
            playerRatingButton2.hidden = false
            playerRatingButton3.hidden = false
            playerRatingButton4.hidden = false
            playerRatingButton5.hidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let buttonArray = [playerRatingButton1 , playerRatingButton2, playerRatingButton3, playerRatingButton4, playerRatingButton5] //storing buttons in array for quick use
        starButtonArray = buttonArray // set to a class global instance
        print("Number of teams to create: " + numberOfTeamsToCreate.description + "\n")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Takes data from UI and creates player
    @IBAction func nextPlayerButton(sender: UIButton) {
        //if not all players have been created, create next player
        if playerCountLabel.text != playerMaxLabel.text{
            //Booleans verifying info for player creation is present
            var nameCheck: Bool = false
            var ratingCheck: Bool = false
            //reload table data
            firstViewTableView.reloadData()
            //Get player name from UI
            if playerNameTextField.text?.isEmpty == true  {
                print("Please enter player name.")
                return
                
            } else {
                playerName = playerNameTextField.text!
                print("Player name: \(playerName)")
                nameCheck = true
            }
            
            //Get player rating from UI
            if playerRating < 1 && isRatedPlayer == true {
                print("Please select a rating for the player.")
                return
            } else {
                ratingCheck = true
            }
            
            //Once both data checks are done, create player
            if nameCheck && ratingCheck && isRatedPlayer == true {
                createRatedPlayer(playerName, pRating: playerRating)
                //reset UI elements
                resetCreatePlayerInput()
            } else if nameCheck && ratingCheck && isRatedPlayer == false{
                createRatedPlayer(playerName, pRating: 1)
                //reset UI elements
                resetCreatePlayerInput()
            }
            
            //check to see if all players have been created and update button label
            if playerCountLabel.text == playerMaxLabel.text{
                //change name of button to indicate next step is to create the actual teams
                nextPlayerButton.setTitle("Create Teams", forState: .Normal)
            }
            
        }else if playerCountLabel.text == playerMaxLabel.text{
            //all players have been created
            performSegueWithIdentifier("FinalTeamsSegue", sender: sender)
        }
        
    }
    
    //create a player with a rating
    func createRatedPlayer( pName : String, pRating : Int) -> Void {
        //Create player and append to player array
        playerArray.append(Player.init(name1: pName, rating1: pRating, team1: 0)) //team = 0 as teams will be selected later
        
        //update players created label
        
        //If labels are hidden make sure they are shown
        if playerCountLabel.hidden == true{
            playerCountLabel.hidden = false
            playerCreatedLabel.hidden = false
            diagonalLineLabel.hidden = false
            playerMaxLabel.hidden = false
        }
        //update current number of players created on appropriate label
        playerCountLabel.text = playerArray.count.description
        
    }
    
    func printPlayerArray(pArray : [Player]) -> Void {
        for var cnt = 0; cnt < pArray.count; cnt++ {
            print("Player Name: \(pArray[cnt].name) Player Rating: \(pArray[cnt].rating) Team: \(pArray[cnt].team)")
        }
    }
    
    //handles star rating button press
    @IBAction func starRatingPressed(sender: UIButton) {
        
        var buttonPressed = 1   //guaranteed at least a value of 1
        //sender.setImage(starImage, forState: .Normal)
        if sender == playerRatingButton1 {
            //set player rating value
            playerRating = 1
            buttonPressed = 1
        } else if sender == playerRatingButton2{
            //set player rating value
            playerRating = 2
            buttonPressed = 2
            
        } else if sender == playerRatingButton3 {
            //set player rating value
            playerRating = 3
            buttonPressed = 3
            
        } else if sender == playerRatingButton4 {
            //set player rating value
            playerRating = 4
            buttonPressed = 4
        } else if sender == playerRatingButton5 {
            //set player rating value
            playerRating = 5
            buttonPressed = 5
        }
        //set star button graphics
        starGraphics(starButtonArray, selectedButton: buttonPressed)
    }
    
    //handles rating graphics once rating is selected
    func starGraphics(buttonArray: [UIButton!], selectedButton : Int) -> Void {
        for var cnt = 0; cnt < buttonArray.count; cnt++ {
            if cnt < selectedButton {
                //set lower rating stars to yellow
                buttonArray[cnt].setImage(starImage, forState: .Normal)
            } else{
                //set all other higher rated stars to gray
                buttonArray[cnt].setImage(starGrayImage, forState: .Normal)
            }
        }
    }

    //resets UI components for player creation
    func resetCreatePlayerInput () ->Void {
        for var cnt = 0; cnt < starButtonArray.count; cnt++ {
                //set all other higher rated stars to gray
                starButtonArray[cnt].setImage(starGrayImage, forState: .Normal)
        }
        playerNameTextField.text = ""
    }
    
    
    // MARK: - Table
    
    //set number of rows for table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxPlayersSet
    }
    
    //handle creation of each individula cell in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        //add image to the cells
        /*let image = UIImage(named: "star")
        cell!.imageView?.image = image
        let highlightedImage = UIImage(named: "star2")
        cell!.imageView?.highlightedImage = highlightedImage */
        
        //add detail text
        /*if indexPath.row < 7 {
            cell!.detailTextLabel?.text = "Quote"
        }else {
            cell!.detailTextLabel?.text = "Age"
        } */
        if playerArray.isEmpty || indexPath.row >= playerArray.count {
            cell!.textLabel!.text = "player" + String(indexPath.row + 1)
            return cell!
        }else {
        cell!.textLabel!.text = playerArray[indexPath.row].name
        //change cell text font
        cell!.textLabel?.font = UIFont .boldSystemFontOfSize(20)
        return cell!
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "FinalTeamsSegue" {
            // Pass the selected object to the new view controller.
            if let destination = segue.destinationViewController as? TeamsTableViewController{
                //send flag if ratings are used or not
                destination.isRatedTeam = isRatedPlayer
                //send players array to the teams table view
                destination.playersArray = playerArray
                //send number of teams to create to the teams table view
                destination.numberOfTeams = numberOfTeamsToCreate
                
            }
            
        }
        
        
        
        /*
        if let destination = segue.destinationViewController as? CreatePlayerViewController {
        //pass the total number of players set by user to create player screen
        destination.maxPlayersSet = maxPlayers
        
        }
        */
        
    }


    @IBAction func BackToMain(sender: AnyObject) {
      performSegueWithIdentifier("BackToMainSegue", sender: sender)
    }
    
    //All players have been entered handles final actions
    @IBAction func doneButtonPress(sender: UIButton) {
        print("done button pressed!")
        printPlayerArray(playerArray)
        
    }
    
    
    
}

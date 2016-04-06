//
//  CreatePlayerViewController.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 3/16/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import UIKit

class CreatePlayerViewController: UIViewController {

    //UI Elements
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var playerRatingButton1: UIButton!
    @IBOutlet weak var playerRatingButton2: UIButton!
    @IBOutlet weak var playerRatingButton3: UIButton!
    @IBOutlet weak var playerRatingButton4: UIButton!
    @IBOutlet weak var playerRatingButton5: UIButton!
    var starButtonArray = [UIButton!]()
    @IBOutlet weak var playerCountLabel: UILabel!   //how many players have been created
    @IBOutlet weak var playerCreatedLabel: UILabel! //"Players Created:" message
    @IBOutlet weak var diagonalLineLabel: UILabel!  //"/"
    @IBOutlet weak var playerMaxLabel: UILabel!     //max players set by user
    
    //UI Images
    let starImage: UIImage = UIImage(named: "star.png")!
    let starGrayImage: UIImage = UIImage(named: "starGray.png")!
    
    //Class Variables
    var playerArray : [Player] = [Player]()         //array of player objects
    var playerName : String = ""                    //player name
    var playerRating : Int = 0                      //player rating (1-5)
    var maxPlayersSet : Int = 0                     //max set by user
    
    
    override func viewWillAppear(animated: Bool) {
        //set visibility for players created labels
        playerCountLabel.hidden = true
        playerCreatedLabel.hidden = true
        diagonalLineLabel.hidden = true
        playerMaxLabel.hidden = true
        playerMaxLabel.text = String(maxPlayersSet)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let buttonArray = [playerRatingButton1 , playerRatingButton2, playerRatingButton3, playerRatingButton4, playerRatingButton5] //storing buttons in array for quick use
        starButtonArray = buttonArray // set to a class global instance
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Takes data from UI and creates player
    @IBAction func nextPlayerButton(sender: UIButton) {
        //Booleans verifying info for player creation is present
        var nameCheck: Bool = false
        var ratingCheck: Bool = false
        
        //Get player name from UI
        if playerNameTextField.text?.isEmpty == true {
            print("Please enter player name.")
            return
            
        } else {
            playerName = playerNameTextField.text!
            print("Player name: \(playerName)")
            nameCheck = true
        }
        
        //Get player rating from UI
        if playerRating < 1 {
            print("Please select a rating for the player.")
            return
        } else {
            ratingCheck = true
        }
        
        //Once both data checks are done, create player
        createRatedPlayer(playerName, pRating: playerRating)
        //reset UI elements
        resetCreatePlayerInput()
        
    }
    
    func createRatedPlayer( pName : String, pRating : Int) -> Void {
        //Create player and append to player array
        playerArray.append(Player.init(name1: playerName, rating1: playerRating, team1: 0)) //team = 0 as teams will be selected later
        //update players created label
        if playerCountLabel.hidden == true{
            playerCountLabel.hidden = false
            playerCreatedLabel.hidden = false
            diagonalLineLabel.hidden = false
            playerMaxLabel.hidden = false
        }
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func BackToMain(sender: AnyObject) {
      performSegueWithIdentifier("BackToMainSegue", sender: sender)
    }
    
    //All players have been entered handles final actions
    @IBAction func doneButtonPress(sender: UIButton) {
        print("done button pressed!")
        printPlayerArray(playerArray)
        
    }
    
    
    
}

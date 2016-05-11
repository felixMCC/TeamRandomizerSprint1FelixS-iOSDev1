//
//  TeamsTableViewController.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 4/19/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import UIKit

class TeamsTableViewController: UITableViewController {

    var playersArray : [Player] = [Player]()                //holds all players and their info
    var finishedTeamsArray : [Team] = [Team]()              //holds finalized teams
    var numberOfTeams : Int = 0                             //number of teams to create selected by user
    var teamsReusableCellIdentifier = "teamsCreatedCell"    //cell to reuse
    var theModel = Model.init()                             //Model object helps in team creation
    var isRatedTeam : Bool = false                          //Flag to show ratings or not
    
    
    override func viewWillAppear(animated: Bool) {
        print("TeamsTableViewController numberOfTeams: " + numberOfTeams.description + "\n")
        //set up teams
        theModel = Model.init(playerArray: playersArray, numberOfTeams: numberOfTeams)  //send the model the data to create teams
        theModel.createTeams()  //create the teams
        finishedTeamsArray = theModel.getTeamArray() //get a local copy of the array of teams.
        printTeams()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //print the teams for testing
    func printTeams() -> Void{
        //get array of teams
        let teams = theModel.getTeamArray()
        
        //for each team in the array print out the players info
        for team in teams{
            team.calculateTeamsSkillLevel()
            print("Team Number: " + team.getTeamNumber().description + "\tTotal Skill Level: " + team.getTeamsTotalSkill().description + "\n"  ) //print team number
            var players = team.getPlayerArray()
            //print out team info
            for var cnt = 0; cnt < team.getCurrentNumberOfPlayers(); cnt++ {
                //print out player info
                var currentPlayer = players[cnt]
                print("Name: " + currentPlayer.name)
                if isRatedTeam == true {
                    print("Rating: " + currentPlayer.rating.description)
                }
                print("Team: " + currentPlayer.team.description + "\n")
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections in the table, which are the number of teams
        return numberOfTeams
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of players
        return (playersArray.count / numberOfTeams) + 1 //plus one to carry odd numbered teams
    }

    //specify optional header in each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //set up team number
        let teamNumber = section + 1
        //get current team
        let currentTeam = finishedTeamsArray[section]
        if isRatedTeam == true{
            currentTeam.calculateTeamsSkillLevel()
            let teamSkillLevel = currentTeam.getTeamsTotalSkill()
            return "Team " + String(teamNumber) + "\tSkill Level: " + String(teamSkillLevel)
        }else {
            return "Team " + String(teamNumber)
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell  teamsReusableCellIdentifier
        var cell = tableView.dequeueReusableCellWithIdentifier(teamsReusableCellIdentifier) as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: teamsReusableCellIdentifier)
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
        
        //If the players array is empty then use filler "player" names
        if playersArray.isEmpty || indexPath.row >= playersArray.count {
            cell!.textLabel!.text = "player" + String(indexPath.row + 1)
            return cell!
        }else {
            //player array is not empty fill with data entered by user
            
            //get current team
            let currentTeam = finishedTeamsArray[indexPath.section]
            //get current players array
            let currentPlayers = currentTeam.getPlayerArray()
            
            //cell!.textLabel!.text = "Section: " + indexPath.section.description +  " Row: " + indexPath.row.description
            if( indexPath.row < currentPlayers.count){
                let player = currentPlayers[indexPath.row]
                cell!.textLabel!.text = player.name
                if isRatedTeam == true{
                    cell!.detailTextLabel?.text = "Skill Level: " + player.rating.description
                }else{
                    cell!.detailTextLabel?.text = ""
                }
                
            }else{
                //fill out empty row (used for holding odd numbered teams)
                cell!.textLabel!.text = ""
                cell?.detailTextLabel?.text = ""
            }
            
            //change cell text font
            cell!.textLabel?.font = UIFont .boldSystemFontOfSize(20)
            return cell!
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

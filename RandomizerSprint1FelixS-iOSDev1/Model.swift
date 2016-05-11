//
//  Model.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 5/1/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import Foundation

class Model{
    
    //Class global variables
    
    //Date objects in order to get system time/date
    let date = NSDate()                             //object to access system date/time
    let calendar = NSCalendar.currentCalendar()     //get current system callendar object
    var teamCreationMode : Int = 0                  //0 = Fair teams using player rating 1 = Randomly assigned teams
    var playerArray : [Player] = [Player]()         //array of player objects created by user
    var teamArray : [Team] = [Team]()               //array of team objects
    var numberOfTeams : Int = 0                     //number of teams to create chosen by user
    var delayValue : Double = 0.0                   //holds delay value
    
    //constructor method for Model
    init(){
        //nil
    }
    
    //constructor taking a premade array of players
    init(playerArray pArray: [Player], numberOfTeams nTeams: Int){
        playerArray = pArray
        numberOfTeams = nTeams
        
    }
    
    //returns the player array
    func getPlayerArray()-> [Player]{
        return playerArray
    }
    
    //returns the team array
    func getTeamArray()-> [Team]{
        return teamArray
    }
    
    //returns number of players
    func getNumberOfPlayers()-> Int{
        return getPlayerArray().count
    }
    
    //returns number of teams player wants to create
    func getNumberOfTeams()-> Int{
        return numberOfTeams
    }
    
    //set the way the program will behave. 0 = Fair teams using player rating 1 = Randomly assigned teams
    func setCreationMode(mode : Int)->Void{
        teamCreationMode = mode
    }
    
    //delays execution on a closure (basically a timer delay)
    func delay(delay:Double, closure:()->()) {
        //execute closure after a delay
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
    }
    
    //generates a random number based off the time
    func randomNumber() -> Int{
        //get current seconds
        //let components = calendar.components( .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date) //Depricated
        let components = calendar.components([.Second], fromDate: date) //get system seconds (Swift 2 call)
        let seconds = components.second
        
        //create seed for random number
        let seed: UInt32 = UInt32(seconds)
        //get random number based off seed (current minute)
        let randomNumber = arc4random_uniform(seed)
        return Int(randomNumber)
    }
    
    //generates a random number from 0 to a value given
    func randomNumberRange(max: Int)->Int{
        //get random number based off seed (current minute)
        let randomNumber = arc4random_uniform(UInt32(max))
        return Int(randomNumber)
    }
    
    
    //creates array of teams and fill them with players
    func createTeams( ){
        var nPlayers = getNumberOfPlayers()
        //Create team objects
        createTeamObjects(getNumberOfTeams(), numPlayers: getNumberOfPlayers())
        //Place players into random teams
        for(var cnt = 0; cnt < nPlayers; ++cnt){
            var currentPlayer = playerArray[cnt]
            //Try to add player to a random team with empty slots
            if(randomlyPlacePlayerIntoTeam(currentPlayer, numTeams: getNumberOfTeams()) < 0){
                //if the random team has no empty slots, try to find one with an open slot
                if(addToTeamWithOpenSlot(currentPlayer) < 0){
                    //if all teams are full, add extra player to team with lowest skill
                    addPlayerToLowestSkillTeam(currentPlayer)
                }
            }
            
        }
        
    }
    
    
    //figures out how many players will fit evenly in each team & creates team objects
    func createTeamObjects(numTeams: Int, numPlayers: Int)->Void{
        print("Number of Teams: " +  numTeams.description + " Number of Players: " + numPlayers.description + "\n")
        //Calculate how many players will fit evenly in a team
        let playersFitEvenly = numPlayers / numTeams //********************************************************* test dividing by zero?
        //println("Players: \(numPlayers) / Teams: \(numTeams) = \(playersFitEvenly)")//testing
        
        //Create team objects
        for var cnt = 1; cnt <= numTeams; ++cnt{
            //Create teams. Set team number, number of players that fit inside, and append them to the array holding all teams
            teamArray.append(Team(teamNumber: cnt, fitEvenly: playersFitEvenly))
        }
    }
    
    //places player into team randomly
    func randomlyPlacePlayerIntoTeam(plyr : Player, numTeams : Int)->Int{
        //get a random team number
        var tempTeamNumber = randomNumberRange(numTeams)
        //get current number of players in this team
        var currentTeamNumberOfPlayers = teamArray[tempTeamNumber].getCurrentNumberOfPlayers();
        
        //if there is an empty slot for player to fit evenly into this team, go ahead and add player to the team
        if(currentTeamNumberOfPlayers < teamArray[tempTeamNumber].getNumberOfPlayersThatFitEvenly()){
            plyr.team = tempTeamNumber  //set player team number
            teamArray[tempTeamNumber].addPlayerToTeam(plyr) //add player to team
            return 0
        }else{
            //player does not fit into randomly selected team
            return -1
        }
    }
    
    //finds a team that still has an empty player slot to fill
    func addToTeamWithOpenSlot(plyr : Player)->Int{
        //println("Finding a team with an open slot")//testing
        for team in teamArray{
            
            //find a team with an open slot and add player to that team
            if(team.getCurrentNumberOfPlayers() < team.getNumberOfPlayersThatFitEvenly()){
                plyr.team = team.getTeamNumber()    //set player team number
                team.addPlayerToTeam(plyr)          //add player to team
                return 0   //found a team, break current loop
            }
        }
        //no teams with empty slots left
        return -1
    }
    
    //makes necessary calls for each team to calculate their current skill level
    func calculateAllTeamsSkillLevels()->Void{
        for team in teamArray{
            team.calculateTeamsSkillLevel()
        }
    }
    
    //finds the team with the lowest skill rating
    func findTeamWithLowestSkill()->Team{
        //get the first team in the array
        var teamLowRating = teamArray[0]
        for(var cnt = 1; cnt < teamArray.count; ++cnt){
            //testing
            //println("Current Lowest Team: \(teamLowRating.getTeamNumber()) Skill: \(teamLowRating.getTeamsTotalSkill()) Comparing to: \(teamArray[cnt].getTeamNumber()) Skill: \(teamArray[cnt].getTeamsTotalSkill())")
            if(teamArray[cnt].getTeamsTotalSkill() < teamLowRating.getTeamsTotalSkill()){
                
                teamLowRating = teamArray[cnt]
                //println("Found NEW lowest rated Team: \(teamLowRating.getTeamNumber())") //testing
            }
        }
        return teamLowRating
    }
    
    //finds the team with the lowest skill rating (sum of player's skill rating) and adds player to team with lowest skill level
    func addPlayerToLowestSkillTeam(currPlayer : Player)->Void{
        //calculate all team's skill levels
        calculateAllTeamsSkillLevels()
        var lowestRatedTeam = findTeamWithLowestSkill()
        currPlayer.team = lowestRatedTeam.getTeamNumber()   //set players team number
        lowestRatedTeam.addPlayerToTeam(currPlayer)         //add player to team
    }
    
    
    
    
    
    
}
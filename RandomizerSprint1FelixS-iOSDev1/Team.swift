//
//  Team.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 3/16/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import Foundation

//Team class holds team info
class Team{
    //Team class variables
    //var name: String = ""                         //team name
    private var teamNumber : Int = 0                //team number
    private var numberOfPlayers: Int = 0            //number of players in team
    private var playersFittingEvenly: Int = 0       //number of players fitting evenly in this team
    private var teamSkill : Int = 0                 //teams total skill (sum of player's skill)
    var teamPlayerArray : [Player] = [Player]()     //holds players in this team
    
    init(tNumber : Int, fitEvenly : Int){
        //do nothing
        self.teamNumber = tNumber               //set team number
        self.playersFittingEvenly = fitEvenly   //set number of players that fit evenly in team
    }
    
    //getter methods
    
    func getTeamNumber()-> Int{
        return teamNumber
    }
    
    func getCurrentNumberOfPlayers()->Int{
        return numberOfPlayers
    }
    
    func getNumberOfPlayersThatFitEvenly()->Int{
        return playersFittingEvenly
    }
    
    func getPlayerArray()->[Player]{
        return teamPlayerArray
    }
    
    func getTeamsTotalSkill()->Int{
        return teamSkill
    }
    
    //increases current number of players in this team
    func increasePlayerCount(){
        numberOfPlayers += 1
    }
    
    //adds player to the Player array
    func addPlayerToTeam(player : Player)->Void{
        //add player to player array
        teamPlayerArray.append(player)
        //increase the number of players in this team
        increasePlayerCount()
    }
    
    //calculates teams total skill level by adding individual players skill level
    func calculateTeamsSkillLevel()->Void{
        if(!teamPlayerArray.isEmpty){
            //reset team skill level
            teamSkill = 0
            //recalculate team skill level
            for player in teamPlayerArray{
                teamSkill += player.rating
            }
        }
    }
}
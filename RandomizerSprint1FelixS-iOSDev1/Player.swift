//
//  Player.swift
//  RandomizerSprint1FelixS-iOSDev1
//
//  Created by Nestor Sotres on 3/16/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import Foundation

//Player class to create players & their stats for the app
class Player{
    //Player class variables/attributes
    var name : String = ""              //holds a players name
    var rating : Int = 0                //players rating level (how good they are)
    var team : Int = 0                  //players team number
    
    //initializing method (player does not start on a team
    init( name1 : String, rating1 : Int){
        self.name = name1
        self.rating = rating1
    }
    
    //initializing method (player starts on a team
    init( name1 : String, rating1 : Int, team1 : Int){
        self.name = name1
        self.rating = rating1
        self.team = team1
    }
    
}//end Player class
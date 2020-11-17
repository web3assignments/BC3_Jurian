// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2; // To fix a type-error we need to enable this.

// This Contract is supposed to become a game where our hero is fighting dragons.
contract Ormr {
    
    //Events
    event encounterResult(string victor); // Emit the result of a battle.
    
    // Mappings
    mapping (address => uint) ownerToHeroId;
    mapping (uint => Dragon) idToDragon;
    
    //Objects/Structs here
    struct Hero {
        uint id;
        string name;
        uint power;
        uint health;
        uint bank;
    }
    
    struct Dragon {
        string name;
        uint id;
        uint power;
        uint health;
        uint goldReward;
    }
    
    // Variables here.
    string victor;
    
    constructor() public {
        Hero memory hero = Hero(
            {
            id : ownerToHeroId[msg.sender],
            name : "default",
            power : 50,
            health : 100,
            bank : 0
        });
        
        Dragon memory firstDragon = Dragon(
            {
            id : (uint(address(this))),
            name : "defaultOrmr",
            power : 60,
            health : 100,
            goldReward : 10
        });
        
        // Start the game!
        Encounter(hero, firstDragon);
        
    }
    
    // Lock in our Hero and the Dragon. Returns the name of the victor of the encounter.
    function Encounter(Hero memory _hero, Dragon memory _dragon) private returns (string memory){
        // Check if there are both a hero and a dragon. Require keyword and ternary operator.
        require(keccak256(abi.encodePacked(_hero.name)) != '', "Hero not found");
        require(keccak256(abi.encodePacked(_dragon.name))!= '', "Dragon not found");
        
        // Fight!
        victor = Battle(_hero.power, _dragon.power);
        emit encounterResult(victor); // Emit our event.
        return victor;
    }
    
    // Determine who wins the fight.
    function Battle(uint heroPower, uint dragonPower) private pure returns (string memory){
        if (heroPower > dragonPower){
            return "The dragon has been slain!";
        }
        else if (heroPower < dragonPower){
            return "The hero has been defeated! The dragon was too strong!";
        }
        else {
            return "The hero and dragon are equal in strength, there is no victor!";
        }
    }
    
}



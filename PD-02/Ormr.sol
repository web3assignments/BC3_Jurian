// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2; // To fix a type-error we need to enable this.

// This Contract is supposed to become a game where our hero is fighting dragons.
contract Ormr {
    
    //Events
    event encounterResult(string); // Emit the result of a battle.
    
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
    Hero hero;
    Dragon dragon;
    Hero[] heroes;
    Dragon[] dragons;
    
    constructor() public {
        Hero memory _hero = Hero(
            {
            id : 1,
            name : "default",
            power : 50,
            health : 100,
            bank : 0
        });
        
        _hero.id = ownerToHeroId[msg.sender];
        
        Dragon memory _dragon = Dragon(
            {
            id : (uint(address(this))),
            name : "defaultOrmr",
            power : 50,
            health : 100,
            goldReward : 10
        });
        
        hero = _hero;
        dragon = _dragon;
        
        // Add the hero and dragon to arrays.
        heroes.push(_hero);
        dragons.push(_dragon);
        
        // Start the game!
        Encounter(hero, _dragon);
        
    }
    
    //Getters and Setters
    function getHero() public view returns (uint) {
        return hero.id;
    }
    
    function getDragon() public view returns (uint){
        return dragon.id;
    }
    
    // Lock in our Hero and the Dragon. Returns the name of the victor of the encounter.
    function Encounter(Hero memory _hero, Dragon memory _dragon) public {
        // Check if there are both a hero and a dragon. Require keyword and ternary operator.
        require(keccak256(abi.encodePacked(_hero.name)) != '', "Hero not found");
        require(keccak256(abi.encodePacked(_dragon.name))!= '', "Dragon not found");
        
        // Fight!
        emit encounterResult(Battle(_hero.power, _dragon.power)); // Emit our event containing result of battle..
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


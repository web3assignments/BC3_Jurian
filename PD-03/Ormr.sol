// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2; // To fix a type-error we need to enable this.

import './HeroFactory.sol';
import './DragonFactory.sol';
import './Dragon.sol';
import './Hero.sol';

// This Contract is supposed to become a game where our hero is fighting dragons.
contract Ormr {
    
    //Events. PD-3 Events.
    event encounterResult(string); // Emit the result of a battle.
    
    // Variables
    HeroFactory HF;
    DragonFactory DF;
    
    // Called once at deployment of the contract.
    constructor() {
        HF = new HeroFactory();
        DF = new DragonFactory();
    }
    
    // Hero logic
    function createHero (string memory _name) public {
        HF.createHero(_name);
    }
    
    function getHero() public view returns (Hero memory) {
        return HF.getHero();
    }
    
    //Dragon logic
    function createDragon () public {
        DF.createDragon();
    }
    
    function getDragon () public view returns (Dragon memory) {
        return DF.getDragon();
    }
    
    // This is the function our user sees when starting a battle.
    function startEncounter() public {
        // Create checks to check whether a hero and dragon are available.
        _encounter(HF.getHero(), DF.getDragon()); // Increase gas limit in remix.
    }
    
    // Lock in our Hero and the Dragon. Emits the result of the encounter.
    function _encounter(Hero memory _hero, Dragon memory _dragon) internal {
        // Check if there are both a hero and a dragon. Require keyword and ternary operator. PD-3 Error Handling.
        require(keccak256(abi.encodePacked(_hero.name)) != keccak256(abi.encodePacked('')), "Hero not found");
        require(keccak256(abi.encodePacked(_dragon.name))!= keccak256(abi.encodePacked('')), "Dragon not found");
        
        // Fight!
        emit encounterResult(_battle(_hero.power, _dragon.power)); // Emit our event containing result of battle..
    }
    
    // Determine who wins the fight.
    function _battle(uint heroPower, uint dragonPower) private pure returns (string memory) {
        if (heroPower > dragonPower) {
            return "The dragon has been slain!";
        }
        else if (heroPower < dragonPower) {
            return "The hero has been defeated! The dragon was too strong!";
        }
        else {
            return "The hero and dragon are equal in strength, there is no victor!";
        }
    }
    
}

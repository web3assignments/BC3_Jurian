// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import './SimpleFactory.sol';
import './Hero.sol';

// Responsible for creating the hero our players can play with!
contract HeroFactory is SimpleFactory {
    
    // Events
    event newHero (uint heroId, string name); 
    
    // Mappings
    mapping (uint => address) heroToOwner;
    mapping (address => uint) heroLookup;
    mapping (address => uint) ownerHeroCount;

    // Variables
    uint heroPowerModulus = 10 ** 5; // Max 5 digits
    uint heroHealthModulus = 10 ** 7; // Max 7 digits.
    Hero hero;
    
    // Keep a list of all existing heroes in the contract.
    Hero[] heroes;
    
    // Getters and Setters
    function getHero(address sender) public view returns (Hero memory) {
        require((heroes.length > 0), "No heroes available for lookup."); // Check if there are heroes.
        return heroes[heroLookup[sender]];
    }
    
    function getHeroes() public view returns (Hero[] memory) {
        require((heroes.length > 0), "No heroes available for lookup."); // Check if there are heroes.
        return heroes;
    }
    
    // Internal function which creates the hero.
    function _createHero(string memory _name, address sender) internal {
        heroes.push(Hero({name : _name, power : randomPower(), health : randomHealth(), bank : 0})); // Default hero power, health and bank.
        uint id = heroes.length  -1; // Different syntax because: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html#how-to-update-your-code 
        heroToOwner[id] = sender; // Assign the hero we just created to the owner's address using the mapping.
        heroLookup[sender] = id; // Assign the address calling the method with the hero array index, enabling lookup from address.
        ownerHeroCount[sender]++; // Increase the count which tracks how many heroes are owned by an address.
        emit newHero(id, _name);
    }
    
    // The player interacts with the contract through this method to create a hero, which checks if they already have a hero.
    function createHero(string memory _name, address sender) public {
        require((ownerHeroCount[sender] == 0), "You already created a hero!"); // Can only have one hero!
        _createHero(_name, sender);
    }
    
    // Semi-Random number generator. W.I.P
    // Determines hero power.
    function randomPower() internal view override returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)))%heroPowerModulus;
    }
    
    // Semi-Random number generator. W.I.P
    // Determines hero health.
    function randomHealth() internal view override returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)))%heroHealthModulus;
    }
    
}

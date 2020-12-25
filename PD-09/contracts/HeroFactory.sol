// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
pragma abicoder v2;

import './SimpleFactory.sol';

/// @dev struct defined here to allow code re-usage: https://docs.soliditylang.org/en/v0.8.0/types.html#structs 
/// this model will be used as hero throughout the app
struct Hero {
    string name;
    uint256 power;
    uint256 health;
    uint256 bank;
}

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice Responsible for creating the hero our players can play with!
/// @dev Working with solidity v0.8.0, creates heroes
contract HeroFactory is SimpleFactory {

    /// @dev emits a newly created hero
    event newHero(uint256 heroId, string name);

    /// @dev these mappings allow linking and looking up heroes that are stored in the contract
    /// with the address of users. OwnerToHeroCount enforces a maximum number of heroes per address
    mapping(uint256 => address) heroToOwner;
    mapping(address => uint256) heroLookup;
    mapping(address => uint256) ownerHeroCount;

    /// @dev determine the maximum length of power and health
    uint256 constant heroPowerModulus = 10**5;
    uint256 constant heroHealthModulus = 10**7;
    Hero hero;

    /// @dev keep a list of all existing heroes in the contract.
    Hero[] heroes;
    
    /// @param sender address of the person interacting with the contract
    /// @return hero object that corresponds with the given sender address
    function getHero(address sender) public view returns (Hero memory) {
        require((heroes.length > 0), "No heroes available for lookup."); 
        return heroes[heroLookup[sender]];
    }

    /// @return array of all heroes in the contract
    function getHeroes() public view returns (Hero[] memory) {
        require((heroes.length > 0), "No heroes available for lookup.");
        return heroes;
    }

    /// @dev Internal function which creates the hero.
    /// @param _name the hero name submitted by the user
    /// @param sender the user's address which we use to link the user and the hero
    function _createHero(string memory _name, address sender) internal {
        heroes.push(
            Hero({
                name: _name,
                power: randomPower(),
                health: randomHealth(),
                bank: 0
            })
        ); // Default hero power, health and bank.
        uint256 id = heroes.length - 1; // Different syntax because: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html#how-to-update-your-code
        heroToOwner[id] = sender; // Assign the hero we just created to the owner's address using the mapping.
        heroLookup[sender] = id; // Assign the address calling the method with the hero array index, enabling lookup from address.
        ownerHeroCount[sender]++; // Increase the count which tracks how many heroes are owned by an address.
        emit newHero(id, _name);
    }

    /// @dev The player interacts with the contract through this method to create a hero, which checks if they already have a hero.
    /// @param _name name submitted by the user
    /// @param sender the user's address which we use to check if a user already has a hero
    function createHero(string memory _name, address sender) public {
        require((ownerHeroCount[sender] == 0), "You already created a hero!");
        _createHero(_name, sender);
    }

    /// @dev Semi-Random number generator.Determines heropower
    /// @return returns hero power
    function randomPower() internal view override returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase))) % heroPowerModulus;
    }

    /// @dev Semi-Random number generator.Determines herohealth
    /// @return returns hero health
    function randomHealth() internal view override returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase))) % heroHealthModulus;
    }
}

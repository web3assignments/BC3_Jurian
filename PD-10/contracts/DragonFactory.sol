// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import './SimpleFactory.sol';

/// @dev struct defined here to allow code re-usage: https://docs.soliditylang.org/en/v0.8.0/types.html#structs 
/// this model will be used as dragon throughout the app
struct Dragon {
    string name;
    address id;
    uint256 power;
    uint256 health;
    uint256 goldReward;
}

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice Responsible for creating dragons
/// @dev Working with solidity v0.8.0, creates dragons
contract DragonFactory is SimpleFactory {

    /// @dev emits a newly created dragon
    event newDragon(Dragon);

    /// @dev allows for looking up specific dragon
    mapping(address => uint256) dragonLookup;

    /// @dev determine the maximum length of power and health
    uint256 constant dragonPowerModulus = 10**5;
    uint256 constant dragonHealthModulus = 10**7;
    Dragon dragon;

    /// @dev keep a list of all existing heroes in the contract.
    Dragon[] dragons;
    
    /// @dev get method that returns one dragon
    function getDragon() public view returns (Dragon memory) {
        require((dragons.length > 0), "No dragons available for lookup.");
        return dragons[dragonLookup[address(this)]];
    }
    
    /// @dev method that returns all dragons known in the contract as an array
    function getDragons() public view returns (Dragon[] memory) {
        require((dragons.length > 0), "No dragons available for lookup.");
        return dragons;
    }

    /// @dev Internal function which creates the dragon.
    function _createDragon() internal {
        dragons.push(
            Dragon({
                name: "Default_Dragon",
                id: address(this),
                power: randomPower(),
                health: randomHealth(),
                goldReward: 10
            })
        );
        uint256 id = dragons.length - 1;
        emit newDragon(dragons[id]);
    }

    /// @dev for now users can create dragons on-demand to play the game
    //TODO: come up with a way so the contract automatically creates a random dragon, refactor this method and front-end when doing so
    function createDragon() public {
        _createDragon();
    }

    /// @dev Semi-Random number generator.Determines dragonpower
    /// @return _power returns dragonpower
    function randomPower() internal view override returns (uint256 _power) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase))) % dragonPowerModulus;
    }

    /// @dev Semi-Random number generator.Determines dragonhealth
    /// @return _health returns dragonhealth
    function randomHealth() internal view override returns (uint256 _health) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase))) % dragonHealthModulus;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
pragma abicoder v2;

import "./SimpleFactory.sol";
import "./Dragon.sol";

// Responsible for creating the dragons our hero can slay!
contract DragonFactory is SimpleFactory {
    // Events
    event newDragon(Dragon);

    // Mappings
    mapping(address => uint256) dragonLookup;

    // Variables
    uint256 dragonPowerModulus = 10**5; // Max 5 digits.
    uint256 dragonHealthModulus = 10**7; // Max 7 digits.
    Dragon dragon;

    // Keep a list of all existing dragons.
    Dragon[] dragons;

    // Getters and Setters
    function getDragon() public view returns (Dragon memory) {
        require((dragons.length > 0), "No dragons available for lookup."); // Check if there are dragons.
        return dragons[dragonLookup[address(this)]];
    }

    function getDragons() public view returns (Dragon[] memory) {
        require((dragons.length > 0), "No dragons available for lookup."); // Check if there are dragons.
        return dragons;
    }

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

    // For ease of testing, this remains public for now..
    function createDragon() public {
        _createDragon();
    }

    // The override keyword has to be present since v0.6.0: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html
    // Semi-Random number generator. W.I.P
    // Determines dragon power.
    function randomPower() internal view override returns (uint256 _power) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        block.coinbase
                    )
                )
            ) % dragonPowerModulus;
    }

    // Semi-Random number generator. W.I.P
    // Determines dragon health.
    function randomHealth() internal view override returns (uint256 _health) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        block.coinbase
                    )
                )
            ) % dragonHealthModulus;
    }
}

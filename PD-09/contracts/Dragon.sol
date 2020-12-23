// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice This is the base for the dragons you're going to encounter
/// @dev Changing this breaks a lot of stuff, approach with caution
struct Dragon {
    string name;
    address id;
    uint256 power;
    uint256 health;
    uint256 goldReward;
}

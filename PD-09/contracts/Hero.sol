// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice This is the base for the hero you're going to play
/// @dev Changing this breaks a lot of stuff, approach with caution
struct Hero {
    string name;
    uint256 power;
    uint256 health;
    uint256 bank;
}

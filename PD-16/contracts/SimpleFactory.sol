// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice Abstraction of the creation of objects for simplicity in code maintenance
/// @dev More info about this pattern: https://refactoring.guru/design-patterns/abstract-factory 
abstract contract SimpleFactory {
    /// @notice This is the base function for determining power in Ormr
    /// @dev Semi random number generator, can be overwritten depending on what is needed. e.g. dragon might want different modulus.
    /// The virtual keyword has to be present since v0.6.0: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html
    /// @param _power semi-random number that will be used for creation later
    function randomPower() internal view virtual returns (uint _power) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)));
    }

    /// @notice This is the base function for determining health in Ormr
    /// @dev Semi random number generator, can be overwritten depending on what is needed. e.g. dragon might want different modulus.
    /// The virtual keyword has to be present since v0.6.0: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html
    /// @param _health semi-random number that will be used for creation later
    function randomHealth() internal view virtual returns (uint _health) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)));
    }
    
}

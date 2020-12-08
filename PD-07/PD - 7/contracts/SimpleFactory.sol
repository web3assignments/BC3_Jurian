// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

// https://refactoring.guru/design-patterns/abstract-factory 

abstract contract SimpleFactory {
    
    // Semi random number generator, can be overwritten depending on what is needed. e.g dragon might want different modulus.
    // The virtual keyword has to be present since v0.6.0: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html
    function randomPower() internal view virtual returns (uint _power) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)));
    }
    
    function randomHealth() internal view virtual returns (uint _health) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, block.coinbase)));
    }
    
}

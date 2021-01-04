// SPDX-License-Identifier: MIT
// truffle run verify Token_erc20 --network rinkeby

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

// Example from Web3Examples: https://github.com/web3examples/ethereum/blob/master/token_examples/ERC20TruffleOpenZeppelin/contracts/Token_erc20.sol 
contract ERC20_BlueEyesWhiteDragonToken is ERC20 {

    /**
     * @dev Constructor that gives _msgSender() all of existing tokens.
     */
    constructor () public ERC20("BlueEyesWhiteDragonToken", "BEWD20") {
        _mint(msg.sender, 100000 * (10 ** 18));
    }
}

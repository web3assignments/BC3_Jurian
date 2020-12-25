// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.21 <=0.8.0;
// import './Initializable.sol';

// contract Migrations is Initializable {
//   address public owner;
//   uint public last_completed_migration;

//   function initialize() public initializer() {
//     owner = msg.sender;
//   }

//   modifier restricted() {
//     if (msg.sender == owner) _;
//   }

//   function setCompleted(uint completed) public restricted {
//     last_completed_migration = completed;
//   }

//   function upgrade(address new_address) public restricted {
//     Migrations upgraded = Migrations(new_address);
//     upgraded.setCompleted(last_completed_migration);
//   }
// }

// PD-9 update, from https://github.com/web3examples/ethereum/blob/master/pattern_examples/Upgrade/contracts/Migrations.sol 
contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}

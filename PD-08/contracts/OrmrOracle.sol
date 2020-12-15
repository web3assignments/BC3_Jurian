// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import './provableAPI.sol';

// Template from web3examples github: https://github.com/web3examples/ethereum/blob/master/oracle_examples/provable_temperature.sol
contract OrmrOracle is usingProvable {
   bytes public temp;
   uint256 public priceOfUrl;
   constructor() payable {}
    
   function __callback(bytes32 /* myid prevent warning*/ , string memory result ) override public {
       if (msg.sender != provable_cbAddress()) revert();
       temp = bytes(result);
   }

   function requestTemp() public payable {
       priceOfUrl = provable_getPrice("URL");
       require (address(this).balance >= priceOfUrl,
            "please add some ETH to cover for the query fee");
       provable_query("URL", 
            "json(http://weerlive.nl/api/json-data-10min.php?key=01464cd625&locatie=Hellevoetsluis).liveweer[0].temp");
   }

   function getTemp() public view returns (bytes memory) {
       return temp;
   }
    
}

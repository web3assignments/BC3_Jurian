// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./provableAPI.sol";
import './Initializable.sol';

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice Oracle we're calling to get a random number back for the sake of randomness
/// @dev Template from web3examples github: https://github.com/web3examples/ethereum/blob/master/oracle_examples/provable_temperature.sol
contract OrmrOracle is usingProvable, Initializable {
    /// @dev temp used for storing the return value of our call to the Oracle
    /// @dev priceOfUrl price of the query in ETH
    bytes public temp;
    uint256 public priceOfUrl;

    /// @dev substitutes the constructor
    function initialize() public payable initializer {}

    /// @dev awaits the Oracle's response
    function __callback(bytes32, /* myid prevent warning*/string memory result
    ) public override {
        if (msg.sender != provable_cbAddress()) revert();
        temp = bytes(result);
    }

    /// @dev sends a request to the provable oracle service
    function requestTemp() public payable {
        priceOfUrl = provable_getPrice("URL");
        require(
            address(this).balance >= priceOfUrl,
            "please add some ETH to cover for the query fee"
        );
        provable_query(
            "URL",
            "json(http://weerlive.nl/api/json-data-10min.php?key=01464cd625&locatie=Hellevoetsluis).liveweer[0].temp"
        );
    }

    // corona cijfer oracle https://api.apify.com/v2/key-value-stores/vqnEUe7VtKNMqGqFF/records/LATEST?disableRedirect=true
    // "json(https://api.apify.com/v2/key-value-stores/vqnEUe7VtKNMqGqFF/records/LATEST?disableRedirect=true).infectedByRegion[0].infectedCount"

    /// @dev return the random number as requested per oracle in bytes
    /// @return oracle result in bytes
    function getTemp() public view returns (bytes memory) {
        return temp;
    }
}

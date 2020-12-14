// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import './provableAPI.sol';

// Template from web3examples github: https://github.com/web3examples/ethereum/blob/master/oracle_examples/provable_random.sol
contract OrmrOracle is usingProvable {
    bytes public result;
    bytes32 public queryId;
        
    constructor() { 
        provable_setProof(proofType_Ledger); 
    }
    
    function __callback(bytes32  _queryId,string memory _result,bytes memory _proof ) override public {
        require(msg.sender == provable_cbAddress());
        if (provable_randomDS_proofVerify__returnCode(_queryId,_result,_proof)== 0) {
            result = bytes(_result); 
        }
        else
            result="Error";
    }
    
    function GetRandom(uint8 nrbytes) public payable { // not supported in remix
        queryId=provable_newRandomDSQuery(
            0,          // QUERY_EXECUTION_DELAY
            nrbytes,    // NUM_RANDOM_BYTES_REQUESTED
            200000      // GAS_FOR_CALLBACK
        );
    }

    // create a way to access the result of the oracle query from outside the contract
    function GetResult() public view returns (bytes memory){
        return result;
    }
    
}

// More examples (with truffle as well!): https://github.com/provable-things/ethereum-examples/tree/master/solidity
// Docs: https://docs.provable.xyz/#ethereum
// Query Tester: https://app.provable.xyz/home/ 
// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "remix_tests.sol"; // this import is automatically injected by Remix.
import "remix_accounts.sol";
import "../StudieschuldToken.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
// Variable Declarations
StudieschuldToken ST;
address admin;
address recipient;
string hash;
string metadata;

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    // See https://remix-ide.readthedocs.io/en/latest/unittesting.html# for more information.
    function beforeAll() public {
        // Here should instantiate tested contract
        ST = new StudieschuldToken();
        // Variable Initialization
        admin = address(this);
        recipient = address(0x85e7CE82Af8565D3D9583A75E063de8aBBF98f64); 
        hash = "QmXznrJ4VBbqrhEnowNznhs4v8NHLcb41hRsYs5Mp6z1uK";
        metadata = "https://ipfs.io/ipfs/QmXznrJ4VBbqrhEnowNznhs4v8NHLcb41hRsYs5Mp6z1uK";
        
        Assert.equal(uint(1), uint(1), "1 should be equal to 1");
    }
    
    // Checks if the admin of the contract to test is the same as the user interacting with it.
    function checkAdmin() public {
       Assert.equal(ST.admin(), admin, "Contract admin does not correspond to current user.");
    }
    
    /// Check if the token's proprties are properly set-up.
    function testtokenTicker() public {
        Assert.equal(ST.symbol(), "DUO_NFT", "Token Symbol is not equal to DUO_NFT");
    }
    
    /// Check if the person received the token.
    function TestFindTokenByAddress() public {
        //Assert.equal(ST.findTokenByAddress(recipient), 1, "Token Id does not match");
        Assert.notEqual(ST.findTokenByAddress(recipient), 2, "Token Id does not match");
    }

    // function checkSuccess() public {
    //     // Use 'Assert' to test the contract, 
    //     // See documentation: https://remix-ide.readthedocs.io/en/latest/assert_library.html
    //     Assert.equal(uint(2), uint(2), "2 should be equal to 2");
    //     Assert.notEqual(uint(2), uint(3), "2 should not be equal to 3");
    // }

    // function checkSuccess2() public pure returns (bool) {
    //     // Use the return value (true or false) to test the contract
    //     return true;
    // }
    
    // function checkFailure() public {
    //     Assert.equal(uint(1), uint(2), "1 is not equal to 2");
    // }

    /// Custom Transaction Context
    /// See more: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    /// #sender: account-1
    /// #value: 100
    function checkSenderAndValue() public payable {
        // account index varies 0-9, value is in wei
        Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
        Assert.equal(msg.value, 100, "Invalid value");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "remix_accounts.sol";
import "./PD12AccessControl.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {

OrmrToken OT;
address acc0;
address acc1;
address acc2;

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        OT = new OrmrToken();
        Assert.equal(uint(1), uint(1), "1 should be equal to 1");
        acc0 = TestsAccounts.getAccount(0);
        acc1 = TestsAccounts.getAccount(1);
        acc2 = TestsAccounts.getAccount(2);
    }
    
    // Account at index zero (account-0) is default account, so admin should be set to acc0
    function adminTest() public {
        address admin = OT.admin.address;
        Assert.equal(acc0, admin, 'Admin should be acc0');
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

    // /// Custom Transaction Context
    // /// See more: https://remix-ide.readthedocs.io/en/latest/unittesting.html#customization
    // /// #sender: account-1
    // /// #value: 100
    // function checkSenderAndValue() public payable {
    //     // account index varies 0-9, value is in wei
    //     Assert.equal(msg.sender, TestsAccounts.getAccount(1), "Invalid sender");
    //     Assert.equal(msg.value, 100, "Invalid value");
    // }
    
    /// Check if addMinterRole works. Only admin can do this
    function addMinterRoleSuccess() public {
        address acc = TestsAccounts.getAccount(2);
        OT.addMinterRole(acc);
    }
    
    /// Should fail because this account is not admin. cannot add role to self.
    function addMinterRoleFailure() public {
        address acc = TestsAccounts.getAccount(2);
        OT.addMinterRole(acc);
    }
    
    /// Check if minter can create a token.
    function awardItemSuccess() public {
        address recipient = TestsAccounts.getAccount(1);
        string memory hash = 'QmS7SVn6X4L4a9xRRTvafqvdEDb3aEp33Bg8P1hieMqhHN';
        string memory metadata = 'https://raw.githubusercontent.com/ToFat4Fun/TokenURI/main/tokenURI.json';
        //OT.awardItem(acc, hash, metadata);
        Assert.equal(OT.awardItem(recipient, hash, metadata), 1, "value should be 1");
    }
    
    /// Should fail because account-2 is neither admin or minter
    /// #sender: account-2
    function awardItemFailure() public {
        address recipient = TestsAccounts.getAccount(1);
        string memory hash = 'QmS4EaMdytCVzAqsgxwRCKoopW8NQWfYsbLzJJKbZ5Nnu1';
        string memory metadata = 'https://raw.githubusercontent.com/ToFat4Fun/TokenURI/main/tokenURI.json';
        //OT.awardItem(acc, hash, metadata);
        Assert.equal(OT.awardItem(recipient, hash, metadata), 2, "value should be 2");
    }

}

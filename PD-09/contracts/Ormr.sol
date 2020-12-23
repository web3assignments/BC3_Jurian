// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./HeroFactory.sol";
import "./DragonFactory.sol";
// import './Hero.sol';
// import './Dragon.sol';
import "./OrmrOracle.sol";
import './Initializable.sol';

/// @title Ormr, Man vs. Dragon
/// @author github@ToFat4Fun
/// @notice Calling the Oracle might take a few seconds to minutes, depending on block processing speed.
/// @dev Working with solidity v0.8.0
contract Ormr is Initializable {
    /// @dev emits the result of the battle initiated by the user. shows in front-end
    event encounterResult(string);

    /// @dev HF herofactory we use to create heroes     
    /// @dev DF dragonfactory we use to create dragons
    /// @dev OO oracle we call for our random functions 
    HeroFactory HF;
    DragonFactory DF;
    OrmrOracle OO;
    address public owner; // PD-9 Modifier

    // PD-9 upgrades. Replace constructor with openzeppelin initialize.
    function initialize() public initializer {
        HF = new HeroFactory();
        DF = new DragonFactory();
        OO = new OrmrOracle();
        owner = msg.sender;
    }

    // PD-9 Modifier
    /// @dev modifier that specifies only the contract owner (address which deployed it) can access a function
    /// More info: https://docs.soliditylang.org/en/v0.8.0/structure-of-a-contract.html?highlight=modifier#function-modifiers and
    /// https://docs.soliditylang.org/en/develop/common-patterns.html#restricting-access 
    modifier onlyOwner
    {
        require(
            msg.sender == owner,
            "Sender not authorized."
        );
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }

    /// @dev function to demonstrate the modifier for PD-9
    /// @return messageFromOwner our owner left a message reminding himself he's the boss
    function ownerSays() public view onlyOwner returns (string memory messageFromOwner) {
        return "I am the owner of this contract! And no one else!";
    }

    /// @dev PD-9 selfdestruct method. More info: https://docs.soliditylang.org/en/v0.8.0/contracts.html#modifiers 
    /// only the contract owner may call this method
    /// Not allowed when using OpenZeppelin, see: https://zpl.in/upgrades/error-003 
    // function destroy() public onlyOwner {
    //     selfdestruct(payable(owner));
    // }

    /// @dev below follows the game logic of creating heroes and dragons, combat and handling Oracle requests
    /// @param _name heroname given by the user
    function createHero(string memory _name) public {
        HF.createHero(_name, msg.sender);
    }

    /// @return return hero associated with the user requesting the address
    function getHero() public view returns (Hero memory) {
        return HF.getHero(msg.sender);
    }

    /// @return returns all heroes in array form
    function getHeroes() public view returns (Hero[] memory) {
        return HF.getHeroes();
    }

    /// @dev creates a dragon using dragonfactory
    function createDragon() public {
        DF.createDragon();
    }

    /// @return returns dragon object
    function getDragon() public view returns (Dragon memory) {
        return DF.getDragon();
    }

    /// @notice here you can initiate a battle! make sure there is both a dragon and hero
    /// @dev This is the function our user sees when starting a battle.
    function startEncounter() public {
        // Calls internal function which handles the encounter
        _encounter(HF.getHero(msg.sender), DF.getDragon());
    }

    /// @dev Lock in our Hero and the Dragon. Emits the result of the encounter.
    /// @param _hero the user's hero
    /// @param _dragon a dragon from within the contract
    function _encounter(Hero memory _hero, Dragon memory _dragon) internal {
        // Check if there are both a hero and a dragon. Require keyword and ternary operator. PD-3 Error Handling.
        require(keccak256(abi.encodePacked(_hero.name)) != keccak256(abi.encodePacked("")), "Hero not found");
        require(keccak256(abi.encodePacked(_dragon.name)) !=keccak256(abi.encodePacked("")), "Dragon not found");

        // calls the method which decides a winner, emits the result afterwards
        emit encounterResult(_battle(_hero.power, _dragon.power));
    }

    /// @dev here is decided who is stronger
    /// @param heroPower hero power
    /// @param dragonPower dragon power
    /// @return the outcome of the battle as string format
    function _battle(uint256 heroPower, uint256 dragonPower) private pure returns (string memory) {
        if (heroPower > dragonPower) {
            return "The dragon has been slain!";
        } else if (heroPower < dragonPower) {
            return "The hero has been defeated! The dragon was too strong!";
        } else {
            return
                "The hero and dragon are equal in strength, there is no victor!";
        }
    }

    /// @dev Let's do something with our Oracle here. Because we want to display uint to the user and our Oracle
    /// returns bytes format, let's convert it here.
    /// Web3examples convert to uint https://github.com/web3examples/ethereum/blob/master/solidity_examples/bytes2uint.sol
    /// @param input the bytes we want to convert to uint
    /// @return the converted bytes value as uint
    function convertToUint(bytes memory input) public pure returns (uint256) {
        uint256 res = 0;
        for (uint256 i = 0; i < input.length; i++)
            res = (res << 8) + uint256(uint8(input[i]));
        return res;
    }

    /// @dev call the oracle using OrmrOracle instance, we need to send ETH as subsequent requests to provable are not free
    /// hence the payable attribute and value: msg.value object
    function callOracleRandom() public payable {
        OO.requestTemp{value: msg.value}();
    }

    /// @dev only request AFTER the oracle has been called (and wait atleast 2 blocks for the result + callback)
    /// otherwise it will return NULL and undefined. This method also converts the result to uint right away for display in the front-end
    /// @return returns the result of the oracle call as uint
    function getTempUint() public view returns (uint256) {
        bytes memory res = OO.getTemp();
        return convertToUint(res);
    }

    /// @dev only request AFTER the oracle has been called (and wait atleast 2 blocks for the result + callback)
    /// otherwise it will return NULL and undefined. This method also converts the result to uint right away for display in the front-end
    /// @return returns the result of the oracle call as bytes
    function getTemp() public view returns (bytes memory) {
        return OO.getTemp();
    }
}

## `Ormr`

Calling the Oracle might take a few seconds to minutes, depending on block processing speed.


Working with solidity v0.8.0

### `onlyOwner()`



modifier that specifies only the contract owner (address which deployed it) can access a function
More info: https://docs.soliditylang.org/en/v0.8.0/structure-of-a-contract.html?highlight=modifier#function-modifiers and
https://docs.soliditylang.org/en/develop/common-patterns.html#restricting-access


### `initialize()` (public)





### `ownerSays() → string messageFromOwner` (public)



function to demonstrate the modifier for PD-9


### `destroy()` (public)



PD-9 selfdestruct method. More info: https://docs.soliditylang.org/en/v0.8.0/contracts.html#modifiers 
only the contract owner may call this method

### `createHero(string _name)` (public)



below follows the game logic of creating heroes and dragons, combat and handling Oracle requests


### `getHero() → struct Hero` (public)





### `getHeroes() → struct Hero[]` (public)





### `createDragon()` (public)



creates a dragon using dragonfactory

### `getDragon() → struct Dragon` (public)





### `startEncounter()` (public)

here you can initiate a battle! make sure there is both a dragon and hero


This is the function our user sees when starting a battle.

### `_encounter(struct Hero _hero, struct Dragon _dragon)` (internal)



Lock in our Hero and the Dragon. Emits the result of the encounter.


### `convertToUint(bytes input) → uint256` (public)



Let's do something with our Oracle here. Because we want to display uint to the user and our Oracle
returns bytes format, let's convert it here.
Web3examples convert to uint https://github.com/web3examples/ethereum/blob/master/solidity_examples/bytes2uint.sol


### `callOracleRandom()` (public)



call the oracle using OrmrOracle instance, we need to send ETH as subsequent requests to provable are not free
hence the payable attribute and value: msg.value object

### `getTempUint() → uint256` (public)



only request AFTER the oracle has been called (and wait atleast 2 blocks for the result + callback)
otherwise it will return NULL and undefined. This method also converts the result to uint right away for display in the front-end


### `getTemp() → bytes` (public)



only request AFTER the oracle has been called (and wait atleast 2 blocks for the result + callback)
otherwise it will return NULL and undefined. This method also converts the result to uint right away for display in the front-end



### `encounterResult(string)`



emits the result of the battle initiated by the user. shows in front-end


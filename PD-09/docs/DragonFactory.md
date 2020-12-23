## `DragonFactory`

Responsible for creating dragons


Working with solidity v0.8.0, creates dragons


### `initialize()` (public)





### `getDragon() → struct Dragon` (public)



get method that returns one dragon

### `getDragons() → struct Dragon[]` (public)



method that returns all dragons known in the contract as an array

### `_createDragon()` (internal)



Internal function which creates the dragon.

### `createDragon()` (public)



for now users can create dragons on-demand to play the game

### `randomPower() → uint256 _power` (internal)



Semi-Random number generator.Determines dragonpower


### `randomHealth() → uint256 _health` (internal)



Semi-Random number generator.Determines dragonhealth



### `newDragon(struct Dragon)`



emits a newly created dragon


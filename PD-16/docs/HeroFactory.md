## `HeroFactory`

Responsible for creating the hero our players can play with!


Working with solidity v0.8.0, creates heroes


### `initialize()` (public)





### `getHero(address sender) → struct Hero` (public)





### `getHeroes() → struct Hero[]` (public)





### `_createHero(string _name, address sender)` (internal)



Internal function which creates the hero.


### `createHero(string _name, address sender)` (public)



The player interacts with the contract through this method to create a hero, which checks if they already have a hero.


### `randomPower() → uint256` (internal)



Semi-Random number generator.Determines heropower


### `randomHealth() → uint256` (internal)



Semi-Random number generator.Determines herohealth



### `newHero(uint256 heroId, string name)`



emits a newly created hero


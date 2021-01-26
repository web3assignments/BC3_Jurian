## `SimpleFactory`

Abstraction of the creation of objects for simplicity in code maintenance


More info about this pattern: https://refactoring.guru/design-patterns/abstract-factory


### `randomPower() → uint256 _power` (internal)

This is the base function for determining power in Ormr


Semi random number generator, can be overwritten depending on what is needed. e.g. dragon might want different modulus.
The virtual keyword has to be present since v0.6.0: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html


### `randomHealth() → uint256 _health` (internal)

This is the base function for determining health in Ormr


Semi random number generator, can be overwritten depending on what is needed. e.g. dragon might want different modulus.
The virtual keyword has to be present since v0.6.0: https://docs.soliditylang.org/en/v0.6.0/060-breaking-changes.html




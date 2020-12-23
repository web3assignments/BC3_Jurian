## `OrmrOracle`

Oracle we're calling to get a random number back for the sake of randomness


Template from web3examples github: https://github.com/web3examples/ethereum/blob/master/oracle_examples/provable_temperature.sol


### `initialize()` (public)



substitutes the constructor

### `__callback(bytes32, string result)` (public)



awaits the Oracle's response

### `requestTemp()` (public)



sends a request to the provable oracle service

### `getTemp() → bytes` (public)



return the random number as requested per oracle in bytes




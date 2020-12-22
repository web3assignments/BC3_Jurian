// Template Set-up for when we eventually want to upgrade our contract.
// const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');
// var Ormr = artifacts.require("Ormr");
// var NewVersionExample = artifacts.require("NewVersionExample");

// module.exports = async function(deployer) {    
//     const Ormr = await Debug1.deployed()
//     const NewVersionExampleContract = await upgradeProxy(Ormr.address, NewVersionExample,{ deployer });

//     console.log(`Address of Ormr: ${Debug1Contract.address}`)
//     console.log(`Address of NewVersionExampleContract: ${NewVersionExampleContract.address}`)

//     // Example Interaction
//     await NewVersionExampleContract.set(5)
//     var bnx = await NewVersionExampleContract.result() // note result is Big Number
//     console.log(`Called function set(5), X is now ${bnx.toString()}`);

// }

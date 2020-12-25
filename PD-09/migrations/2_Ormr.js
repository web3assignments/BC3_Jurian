// PD-9 OpenZeppelin Upgrade
var { deployProxy } = require('@openzeppelin/truffle-upgrades');

var DragonFactory = artifacts.require("DragonFactory");
var HeroFactory = artifacts.require("HeroFactory");
var Ormr = artifacts.require("Ormr");
// PD-8 Oracle
var Oracle = artifacts.require("OrmrOracle");

//!PD-9 selfdestruct error: https://zpl.in/upgrades/error-003 
// unsafeAllowCustomTypes is needed because contracts use structs: https://docs.openzeppelin.com/upgrades-plugins/1.x/api-truffle-upgrades 
module.exports = async function(deployer) {
    const DragonFactoryContract = await deployProxy(DragonFactory, { deployer, unsafeAllowCustomTypes:true });
    const HeroFactoryContract = await deployProxy(HeroFactory, { deployer, unsafeAllowCustomTypes:true });
    const OracleContract = await deployProxy(Oracle, { deployer });
    const OrmrContract = await deployProxy(Ormr, { deployer, unsafeAllowCustomTypes:true });

    console.log(`DragonFactory deployed at: ${DragonFactoryContract.address}`);
    console.log(`HeroFactory deployed at: ${HeroFactoryContract.address}`);
    console.log(`Ormr deployed at: ${OrmrContract.address}`);
    console.log(`Oracle deployed at: ${OracleContract.address}`);

}

// module.exports = async function(deployer) {
//     await deployer.deploy(DragonFactory);
//     await deployer.deploy(HeroFactory);
//     await deployer.deploy(Oracle);
//     await deployer.deploy(Ormr);

//     DF = await DragonFactory.deployed();
//     HF = await HeroFactory.deployed();
//     Ormr = await Ormr.deployed();
//     Oracle= await Oracle.deployed();

//     console.log(`DragonFactory deployed at: ${DF.address}`);
//     console.log(`HeroFactory deployed at: ${HF.address}`);
//     console.log(`Ormr deployed at: ${Ormr.address}`);
//     console.log(`Oracle deployed at: ${Oracle.address}`);
// }

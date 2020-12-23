// PD-9 OpenZeppelin Upgrade
var { deployProxy } = require('@openzeppelin/truffle-upgrades');

var Migrations = artifacts.require("Migrations");
var DragonFactory = artifacts.require("DragonFactory");
var HeroFactory = artifacts.require("HeroFactory");
var Ormr = artifacts.require("Ormr");
// PD-8 Oracle
var Oracle = artifacts.require("OrmrOracle");

module.exports = async function(deployer) {
    await deployer.deploy(Migrations);
    await deployer.deploy(DragonFactory);
    await deployer.deploy(HeroFactory);
    await deployer.deploy(Oracle);
    await deployer.deploy(Ormr);
    //var OrmrDeploy = await deployProxy(Ormr, { deployer }); // WIP

    Mig = await Migrations.deployed();
    DF = await DragonFactory.deployed();
    HF = await HeroFactory.deployed();
    Ormr = await Ormr.deployed();
    Oracle= await Oracle.deployed();

    console.log(`Migrations deployed at: ${Migrations.address}`);
    console.log(`DragonFactory deployed at: ${DF.address}`);
    console.log(`HeroFactory deployed at: ${HF.address}`);
    console.log(`Ormr deployed at: ${Ormr.address}`);
    console.log(`Oracle deployed at: ${Oracle.address}`);
}

// !PD-9 migration error: https://i.imgur.com/pieRiIf.png W.I.P!
// module.exports = async function(deployer) {
//     const MigrationsContract = await deployProxy(Migrations, { deployer });
//     const DragonFactoryContract = await deployProxy(DragonFactory, { deployer, unsafeAllowCustomTypes:true });
//     const HeroFactoryContract = await deployProxy(HeroFactory, { deployer, unsafeAllowCustomTypes:true });
//     const OracleContract = await deployProxy(Oracle, { deployer });
//     const OrmrContract = await deployProxy(Ormr, { deployer, unsafeAllowCustomTypes:true });

//     console.log(`Migrations deployed at: ${MigrationsContract.address}`);
//     console.log(`DragonFactory deployed at: ${DragonFactoryContract.address}`);
//     console.log(`HeroFactory deployed at: ${HeroFactoryContract.address}`);
//     console.log(`Ormr deployed at: ${OrmrContract.address}`);
//     console.log(`Oracle deployed at: ${OracleContract.address}`);

// }

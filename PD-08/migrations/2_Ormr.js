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
    await deployer.deploy(Ormr);
    await deployer.deploy(Oracle);

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

var Migrations = artifacts.require("Migrations");
var DragonFactory = artifacts.require("DragonFactory");
var HeroFactory = artifacts.require("HeroFactory");
var Ormr = artifacts.require("Ormr");

module.exports = async function(deployer) {
    await deployer.deply(Migrations);
    await deployer.deploy(DragonFactory);
    await deployer.deploy(HeroFactory);
    await deployer.deploy(Ormr);

    DF = await DragonFactory.deployed();
    HF = await HeroFactory.deployed();
    Ormr = await Ormr.deployed();

    console.log(`Migrations deployed at: ${Migrations.address}`);
    console.log(`DragonFactory deployed at: ${DF.address}`);
    console.log(`HeroFactory deployed at: ${HF.address}`);
    console.log(`Ormr deployed at: ${Ormr.address}`);
}

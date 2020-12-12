// Let's use the contract we deployed on the Rinkeby test network!
// Contract Address: https://rinkeby.etherscan.io/address/0x648a8087721bb3f68d2e9217a55850bfacece905

const contract_address = '0x648a8087721bb3f68d2e9217a55850bfacece905';

// Compile your contract in remix, then go to the .JSON artifact and ABI will be there.
const abi = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"name": "encounterResult",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "createDragon",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"name": "createHero",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getDragon",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "id",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "power",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "health",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "goldReward",
						"type": "uint256"
					}
				],
				"internalType": "struct Dragon",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getHero",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "power",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "health",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "bank",
						"type": "uint256"
					}
				],
				"internalType": "struct Hero",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getHeroes",
		"outputs": [
			{
				"components": [
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "power",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "health",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "bank",
						"type": "uint256"
					}
				],
				"internalType": "struct Hero[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "startEncounter",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

var contract;
var accounts;

// Function from web3examples. responsible for loading the provider.
async function asyncloaded() {
    web3 = new Web3(Web3.givenProvider); // provider from metamask      
    var result = await web3.eth.requestAccounts().catch(x => console.log(x.message));
    console.log(`web3 is present: ${web3.version}`); // note: use ` (back quote)
    const network = await web3.eth.net.getId().catch((reason) => console.log(`Cannnot find network ${reason}`));
    if (typeof network === 'undefined' || network != 4) { console.log("Please select Rinkeby test network"); return; }
    console.log("Ethereum network: Rinkeby")
    accounts = await web3.eth.getAccounts();
    console.log(accounts[0]); // show current user.
    contract = new web3.eth.Contract(abi, contract_address);
}
window.addEventListener('load', asyncloaded);       

// Contract functions:
// Create our hero! Maximum one per address.
function createHero() {
    var heroName = document.getElementById('heroName').value;
    contract.methods.createHero(heroName).send({from: accounts[0]}).then(x => console.log(x));
}

// Get our hero.
async function getHero() {
	var result = await contract.methods.getHero().call({from: accounts[0]}).then(x => {console.log(x); return x});
	document.getElementById('getHeroName').innerText = result["name"];
	document.getElementById('getHeroPower').innerText = result.power;
	document.getElementById('getHeroHealth').innerText = result.health;
}

// Get all heroes in the contract!
async function getHeroes() {
	var result = await contract.methods.getHeroes().call().then(x => { console.log(x); return x});
	// document.getElementById('allHeroes').innerText = result;

	// Stackoverflow solution for creating a list. https://stackoverflow.com/a/34287777
	var div = document.getElementById("allHeroes");
	var ol = document.createElement("ol");
	for(var i = 0; i < result.length; i++){
		var li = document.createElement("li");
		//document.getElementById('allHeroes').innerHTML += result[i].name;
		li.innerHTML = result[i].name;
		ol.appendChild(li);
	}
	div.appendChild(ol);
}

// Create dragon to interact with.
function createDragon() {
    contract.methods.createDragon().send({from: accounts[0]}).then(x => console.log(x));
}

// Get our dragon!
async function getDragon() {
	var result = await contract.methods.getDragon().call().then(x => {console.log(x); return x});
	document.getElementById('getDragonName').innerText = result.name;
}

// Fight! Has to be async because we have to wait for the contract/blockchain to return something
async function startEncounter() {
	document.getElementById('encounterResult').innerText = 'Stand by while your hero is fighting a dragon⚔️🐉';
    var result = await contract.methods.startEncounter().send({from: accounts[0]}).then(x => {console.log(x); return x});
	console.log(result);
	document.getElementById('encounterResult').innerText = result.events.encounterResult.returnValues[0];
	alert('Outcome: ' + result.events.encounterResult.returnValues[0]);
}


// Search for an address starting with a specified prefix (find). PD-5 blockchainminor.
// Ran with Visual Studio Code.
console.log('Start!');
Web3 = require('web3');
web3 = new Web3();
var i = 0;
var find = "5555";
var findLength_plus2 = find.length+2; //get the address prefix
var prefix;

do {
    newAddress = web3.eth.accounts.create();
    prefix = newAddress.address.slice(2,findLength_plus2).toLowerCase();
    if (i++ % 1000 == 0) console.log(i);
} while (prefix != find);

console.log(`found an address with prefix: ${prefix}`);
console.log(`address: ${newAddress.address}`);
console.log(`privatekey: ${newAddress.privateKey}`);

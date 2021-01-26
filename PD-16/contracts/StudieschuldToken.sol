// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC721/ERC721.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/Counters.sol";

// edit NFT for IPFS usage: https://medium.com/pinata/how-to-build-erc-721-nfts-with-ipfs-e76a21d8f914 
contract StudieschuldToken is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(string => uint8) hashes;
    mapping(address => uint256) internal lookupByAddress; // Enables lookup of a token by receiving address input
    address public admin;

    constructor() ERC721("Studieschuld Token Proof", "DUO_NFT") {
        admin = msg.sender;
    }

    // Responsible for creating a token, checks if address does not already own a token, then adds metadata.
    function awardItem(address recipient, string memory hash, string memory metadata) public returns (uint256) {
        require(msg.sender == admin); // Only contract owner, which should be DUO, is allowed to create tokens!
        require(hashes[hash] != 1); // Only one token per address. Studieschuld is unique!
        hashes[hash] = 1;
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        lookupByAddress[recipient] = newItemId; // Link address of recipient with token        
        _mint(recipient, newItemId); // Create the token and couple tokenId with recipent address
        _setTokenURI(newItemId, metadata); // Fill in the metadata, e.g. Amount of Debt, Type of Debt, Monthly redemption etc.
        return newItemId;
    }

    // Allows for modifying a token's metadata by uploading a new URI. Useful to update debt or status. 
    function setTokenURI(uint256 _tokenID, string memory URI) public {
        require(msg.sender == admin);
        _setTokenURI(_tokenID, URI);
    }
    
    // Returns the id of the token owned by the address
    // Same as tokenOfOWnerByIndex but you don't have to supply the index (which is 0)
    function findTokenByAddress(address _owner) public view returns (uint256 tokenId) {
        return lookupByAddress[_owner];
    }

}

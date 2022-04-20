// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";



contract NFT is ERC721URIStorage{
    using Counter for Counters.counter;
    Counters.Counter private _tokenIds;
    address contractAddress;

    constructor(address marketplace) ERC721("Metaverse Tokens","METT"){
             contractAddress = marketplace;
    }

    function createToken(string memory tokenURI)public returns(uint){
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);

        return newItemId;


    }


}

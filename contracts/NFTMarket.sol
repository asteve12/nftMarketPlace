// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTMarket is ReentrancyGuard{
using Counters for Counters.Counter;
Counters.Counter private _itemIds;
Counters.Counter private _itemsSold; 

address payable owner; 
uint256 listingPrice = 0.025 ether;

constructor (){
    owner = payable(msg.sender);
}

struct MarketItems{
    uint itemId,
    address nftContract;
    uint256 tokenId,
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold
}

mapping(uint => MarketItems)private  idToMarketItems;
event MarketIemCreated{
    uint indexed itemId,
    address indexed nftContract,
    uint256 indexed tokenId,
    address seller,
    address owner,
    uint256 price,
    bool sold
}

function getistingPrice() public view returns(uint256){
    return listingPrice;
}

function createMarketItem(address nftContract,uint256 tokenId,uint256 price)public payable nonReentrant{
require (price > 0,"Price must be equal to listing price");
require(msg.value === listingPrice,"Price must be equal to  listing price");
 _itemIds.increment();
 
 uint256 itemId = _itemIds.current();
 idToMarketItems[itemId] = MarketIemCreated(itemId,nftContract,tokenId,payable(msg.sender),payable(address(0)),price,false)
IERC721(nftContract).transferFrom(msg.sender,address(this),tokenId);
emit MarketIemCreated(itemId,nftContract,tokenId,msg.sender,address(0),price,false)

}


function createMarketSale(address nftContract,uint256 itemId)public payable nonReentrant{
uint price = idToMarketItems[itemId].price;
uint tokenId = idToMarketItems[itemId].tokenId;
require(msg.value === price,"Please submit the asking price in order to complete the purchase");
idToMarketItems[itemId].seller.transfer(msg.value);
IERC721(nftContract).transferFrom(address(this),msg.sender,tokenId);
idToMarketItems[itemId].owner = payable(msg.sender);
idToMarketItems[itemId].sold = true;
_itemsSold.increment();
payable(owner).transfer(listingPrice);

}

function fetchMarketItems()public view returns(MarketItems[] memory){
    uint itemCount = _itemIds.current();
    uint unsoldItemCount = _itemIds.current()-_itemsSold.current();
    uint currentIndex = 0;
    MarketItems[] memory items = new MarketItem[](unsoldItemCount)
    for(uint i =0; i < itemCount;i++){
        if(idToMarketItem[i+1].owner === address(0)){
            uint currentId = idToMarketItem[i+1].itemId;
            MarketItem storage currentItem = idToMarketItem[currentId];
            items[currentIndex] = currentItem;
            currentIndex += 1;


        }
        

        return items;

    }


}








}

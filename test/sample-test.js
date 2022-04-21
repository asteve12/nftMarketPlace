const { expect } = require("chai");
const { ethers } = require("hardhat");

describe('NFTMarket', async function () {
  it('it should create and execute sales', async function () {
    const Market = await ethers.getContractFactory('NFTMarket');
    const market = await Market.deploy();
    await market.deployed();
    const markerAddress = market.address;

    const NFT = await ethers.getContractFactory("NFT");
    const nft = await NFT.deploy(markerAddress);
    await nft.deployed();
    const nftContractAddress = nft.address;

    let listingPrice = await market.getListingPrice();
    listingPrice = listingPrice.toString();
    const auctionPrice = ethers.utils.parseUnits("100","ether");

    await nft.createToken("https://www.mytokenlocation.com");
    await nft.createToken('https://www.mytokenlocation.com');

    await market.createMarketItem(nftContractAddress,1,auctionPrice,{value:listingPrice});
      await market.createMarketItem(nftContractAddress, 2, auctionPrice, {
        value: listingPrice,
      });

  });


  const [_,buyerAddress] = await ethers.getSigner()
  await market.connect(buyerAddress).createMarketSale(nftContractAddress,1,{value:auctionPrice});

  const items = await market.fetchMarketItems();
  console.log("items:",items);
    console.log('steve test');
});

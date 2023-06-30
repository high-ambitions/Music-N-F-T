//SPDX-License-Identifier : MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MusicNFTMarketplace is ERC721("DAppFi","DAPP"),Ownable{
string public baseURI =
        "https://bafybeidhjjbjonyqcahuzlpt7sznmh4xrlbspa3gstop5o47l6gsiaffee.ipfs.nftstorage.link/";
string public baseExtension=".json";
address public artist;
uint256 public royaltyFee;

 struct MarketItem{
      uint256 tokenId;
      address payable seller;
      uint256 price;
 }
 MarketItem[] public marketItems;
 

/* In constructor we initalize royalty fee, artist address and prices of music nfts*/
    constructor(
        uint256 _royaltyFee,
        address _artist,
        uint256[] memory _prices
    ) payable {
        require(
            _prices.length * _royaltyFee <= msg.value,
            "Deployer must pay royalty fee for each token listed on the marketplace"
        );
         artist = _artist;
         royaltyFee = _royaltyFee;

        for (uint8 i = 0; i < _prices.length; i++) {
            require(_prices[i] > 0, "Price must be greater than 0");
            _mint(address(this), i);
            marketItems.push(MarketItem(i, payable(msg.sender), _prices[i]));
        }
    }




}

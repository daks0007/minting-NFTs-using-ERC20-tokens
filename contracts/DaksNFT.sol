// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DaksNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    IERC20 public tokenAddress; //using the IERC20 Interface
    uint256 public rate =1*10**2; //rate of 1 NFT in form of DaksToken(ERC20)

    Counters.Counter private _tokenIdCounter;
      
    constructor(address _tokenAddress) ERC721("DaksNFT", "DFT") {
        tokenAddress=IERC20(_tokenAddress);
    }
//minting function with a modification to accept custom ERC20 tokens as payment for NFTs
    function safeMint(uint256 token_amount) public {
        
        tokenAddress.transferFrom(msg.sender,address(this), rate*token_amount);//using the transferFrom funtion of the already deployed ERC20 contract(DaksToken) to tranfer the tokens from the msg.sender to the NFT(address(this)) contract 
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }
    //funtion to withdraw the DaksToken(DAK) --ERC20 tokens-- from the contract address to the owners address
    function withdrawToken() public onlyOwner{
        tokenAddress.transfer(msg.sender, tokenAddress.balanceOf(address(this)));

    }
    //Funtion to sell the NFT's(if the msg.sender has the balance) and get DaksToken(ERC20) in place of it
    function sell_NFT(uint256 _amount)public{
        require(_balances[msg.sender]>=_amount);//checks the balance oft he msg.sender
        tokenAddress.transferFrom(address(this),msg.sender, rate*_amount);//transfers the tokens from this contract to the msg.sender
        _balances[msg.sender]-=_amount;//decreases the amount of nfts from the msg.sender

    }
}
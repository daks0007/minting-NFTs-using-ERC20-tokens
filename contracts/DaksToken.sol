// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//This is a simple ERC20 token contract 

 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract DaksToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Daks", "DAK", 2) {
        _mint(msg.sender, initialSupply);//initialSupply -amount of tokens that is sent to the owners address
        //as it was a constant value i formed a .env file
    }
}
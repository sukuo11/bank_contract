// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{

    mapping(address => uint) public balances;
    address public owner;
    uint eth_balance;
    address[3] public top_3;

    constructor() {
    owner = msg.sender;
    }

    function receive() external payable { 
        balances[msg.sender] = balances[msg.sender] + msg.value;
        eth_balance += msg.value;
        if (balances[top_3[0]] < balances[msg.sender]){
            if (top_3[1] == msg.sender){
                top_3[1] = top_3[0];
                top_3[0] = msg.sender;
            }
            else {
            top_3[2] = top_3[1];
            top_3[1] = top_3[0];
            top_3[0] = msg.sender;
            }
            
        }
        else if (balances[top_3[1]] < balances[msg.sender]){
            top_3[2] = top_3[1];
            top_3[1] = msg.sender;
        }
        else if (balances[top_3[2]] < balances[msg.sender]){
            top_3[2] = msg.sender;
        }

        
    }
    
    function withdraw() public  {
        require(msg.sender == owner);
        payable(msg.sender).transfer(eth_balance);
        eth_balance = 0;
    }
}
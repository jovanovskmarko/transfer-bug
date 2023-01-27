// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract EthReceive is Ownable{

    function deposit() external payable {
        // deposit ether
    }

    function withdraw(uint256 _amount) public payable onlyOwner{
        require(address(this).balance >= _amount,"The ammount to withdraw is greater than the balance");
        require(_amount > 0,"Cannot withdraw 0 Eth");
        //TODO transfer fails and call doesn't send
        payable(msg.sender).call{value:_amount * 10**18}("");
    }


}
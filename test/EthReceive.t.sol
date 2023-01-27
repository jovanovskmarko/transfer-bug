// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/EthReceive.sol";
import "ds-test/test.sol"; 
import "forge-std/console.sol";



contract CounterTest is Test {
    EthReceive private ethReceive;

    function setUp() public {
        ethReceive = new EthReceive();

    }

    function testDeposit() public {
       uint256 balance = address(ethReceive).balance;
       assertEq(balance,0);
       ethReceive.deposit{value:10 ether}();
       assertEq(address(ethReceive).balance,10 ether);
    }

    function testWithdrawFromOtherAccount() public{
        vm.prank(0x1B7BAa734C00298b9429b518D621753Bb0f6efF2);
        vm.expectRevert("Ownable: caller is not the owner");
        ethReceive.withdraw(1);
    }

    function testWithdraw() public{
        vm.expectRevert("The ammount to withdraw is greater than the balance");
        ethReceive.withdraw(1);
    }

    function testWithdrawFromOwner() public {
        ethReceive.deposit{value:2 ether}();
        assertEq(address(ethReceive).balance,2 ether);
        ethReceive.withdraw(1);
        emit log_uint(address(ethReceive).balance);
    }
}
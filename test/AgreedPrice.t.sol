// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/AgreedPrice.sol";
import "ds-test/test.sol"; 
import "forge-std/console.sol";



contract CounterTest is Test {
    AgreedPrice private agreedPrice;

    function setUp() public {
        agreedPrice = new AgreedPrice(100);

    }

    function testPrice() public{
        assertEq(agreedPrice.price(), 100);
    }

    function testOwner() public {
        agreedPrice.updatePrice(500);
        uint256 value = agreedPrice.price();
        assertEq(agreedPrice.price(), 500);
        emit log_named_uint("The value is ",value);
    }

    function testUpdatePriceFromOtherAccount() public{
        vm.prank(0x1B7BAa734C00298b9429b518D621753Bb0f6efF2);
        agreedPrice.updatePrice(600);
        assertEq(agreedPrice.price(), 600);
    }
}
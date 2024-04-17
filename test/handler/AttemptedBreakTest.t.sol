// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {HandlerStatefulFuzzCatches} from "../../src/invariant-break/HandlerStatefulFuzzCatches.sol";
import {MockUSDC} from "../mocks/MockUSDC.sol";
import {YeildERC20} from "../mocks/YeildERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AttemptedBreakTest is StdInvariant, Test {
    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    YeildERC20 yeildERC20;
    MockUSDC mockUSDC;
    IERC20[] supportedTokens; // we are importing it into this test because
    //it is set in the contstructor of handlerstatefulfuzzcatches.sol
    uint256 startingAmount;

    address user = makeAddr("user");

    function setUp() public {
        vm.startPrank(user);
        //first we are going to launch these tokens
        yeildERC20 = new YeildERC20();
        mockUSDC = new MockUSDC();
        startingAmount = yeildERC20.INITIAL_SUPPLY();
        mockUSDC.mint(user, startingAmount);
        vm.stopPrank();

        //we are pushing these tokens as suppoorted tokens
        supportedTokens.push(mockUSDC);
        supportedTokens.push(yeildERC20);
        handlerStatefulFuzzCatches = new HandlerStatefulFuzzCatches(supportedTokens);
        targetContract(address(handlerStatefulFuzzCatches));
    }

    // function testStartingAmountTheSame() public view {
    //     assert(startingAmount == yeildERC20.balanceOf(user));
    //     assert(startingAmount == mockUSDC.balanceOf(user));
    // }

    // function statefulFuzz_testInvariantBreaks() public {
    //     vm.startPrank(user);
    //     handlerStatefulFuzzCatches.withdrawToken(mockUSDC);
    //     handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
    //     //we're assuming that during the test it will call deposit and we will
    //     //withdraw the same amount of tokens using this .
    //     vm.stopPrank();

    //     assert(mockUSDC.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
    //     assert(yeildERC20.balanceOf(address(handlerStatefulFuzzCatches)) == 0);
    //     //the balalnce of both of these tokens will return to zero.

    //     assert(mockUSDC.balanceOf(user) == startingAmount);
    //     assert(yeildERC20.balanceOf(user) == startingAmount);
    //     //the balance of the user will return to the same amount as it was before.
    // }
}

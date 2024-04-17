// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {HandlerStatefulFuzzCatches} from "../../src/invariant-break/HandlerStatefulFuzzCatches.sol";
import {YeildERC20} from "../mocks/YeildERC20.sol";
import {MockUSDC} from "../mocks/MockUSDC.sol";

contract Handler is Test {
    HandlerStatefulFuzzCatches handlerStatefulFuzzCatches;
    MockUSDC mockUSDC;
    YeildERC20 yeildERC20;
    address user;

    constructor(
        HandlerStatefulFuzzCatches _handlerStatefulFuzzCatches,
        MockUSDC _mockUSDC,
        YeildERC20 _yeildERC20,
        address _user
    ) {
        handlerStatefulFuzzCatches = _handlerStatefulFuzzCatches;
        mockUSDC = _mockUSDC;
        yeildERC20 = _yeildERC20;
        user = _user;
    }

    function depositYeildERC20(uint256 _amount) public {
        uint256 amount = bound(_amount, 0, yeildERC20.balanceOf(user));
        //"bound" is a mathematical function for wrapping inputs of fuzz tests into a certain range
        /*example : _amount=0,amount will be 0
                    _amount=1,amount will be 1
                     _amount=2,amount will be 2
                    _amount=3,amount will be 3
        */
        vm.startPrank(user);
        yeildERC20.approve(address(handlerStatefulFuzzCatches), amount);
        handlerStatefulFuzzCatches.depositToken(yeildERC20, amount);
        vm.stopPrank();
    }

    function depositMockUSDC(uint256 _amount) public {
        uint256 amount = bound(_amount, 0, mockUSDC.balanceOf(user));
        vm.startPrank(user);
        mockUSDC.approve(address(handlerStatefulFuzzCatches), amount);
        handlerStatefulFuzzCatches.depositToken(mockUSDC, amount);
        vm.stopPrank();
    }

    function withdrawYeildERC20() public {
        vm.startPrank(user);
        handlerStatefulFuzzCatches.withdrawToken(yeildERC20);
        vm.stopPrank();
    }

    function withdrawMockUSDC() public {
        vm.startPrank(user);
        handlerStatefulFuzzCatches.withdrawToken(mockUSDC);
        vm.stopPrank();
    }
}

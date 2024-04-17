//SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StatefulFuzzCatches} from "../../src/invariant-break/StatefulFuzzCatches.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";

contract StatefulFuzzCatchesTest is Test {
    StatefulFuzzCatches Sfc2;

    function setUp() public {
        Sfc2 = new StatefulFuzzCatches();
        targetContract(address(Sfc2));
    }

    function testdoMoreMathAgain(uint128 newValue) public {
        assert(Sfc2.doMoreMathAgain(newValue) != 0);
    }

    function statefulFuzz_catchesInvariant() public view {
        assert(Sfc2.storedValue() != 0);
    }
}

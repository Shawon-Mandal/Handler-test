// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*//////////////////////////////////////////////////////////////
                            OVERFLOW
//////////////////////////////////////////////////////////////*/

contract Overflow {
    uint8 public count;

    function increment() public {
        unchecked {
            count++;
        }
    }
}

/*//////////////////////////////////////////////////////////////
                            UNDERFLOW
//////////////////////////////////////////////////////////////*/

contract Underflow {
    uint8 public count;

    function decrement() public {
        unchecked {
            count--;
        }
    }
}

/*//////////////////////////////////////////////////////////////
                            PRECISION LOSS
//////////////////////////////////////////////////////////////*/

contract PrecisionLoss {
    uint256 public moneyToSplitUp = 225;
    uint256 public users = 4;

    function shareMoney() public view returns (uint256) {
        return moneyToSplitUp / users;
    }
}

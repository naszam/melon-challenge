/// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

import "./IAdapter.sol";
import "./IntegrationSignatures.sol";
import "./IWeth.sol";
import "./IETHJoin.sol";


/// @title Maker Adapter contract
/// @dev This is the main file that you'll need to edit to implement your adapter's behavior
contract MakerAdapter is IAdapter, IntegrationSignatures {

      address immutable public ETHJoin;
      address immutable public WETH;


      constructor(address eth_, address weth_) public {

        ETHJoin = eth_;
        WETH = weth_;

      }

    /// @notice Parses the fund assets to be spent given a specified adapter method and set of encoded args
    /// @param _methodSelector The bytes4 selector for the function signature being called
    /// @param _encodedArgs The encoded params to use in the integration call
    /// @return outgoingAssets_ The fund's assets to use in the integration call
    /// @return outgoingAmounts_ The amount of each of the fund's assets to use in the integration call
    function parseOutgoingAssets(bytes4 _methodSelector, bytes calldata _encodedArgs)
        external
        view
        override
        returns (address[] memory outgoingAssets_, uint256[] memory outgoingAmounts_)
    {
        // 2. Complete this function, which is meant to parse the expected assets that each function method will use
        if (_methodSelector == BORROW_SELECTOR) {
          (uint etherQuantity) = __decodeBorrowArgs(_encodedArgs);

          outgoingAssets_ = new address[](1);
          outgoingAssets_[0] = ETHJoin;
          outgoingAmounts_[0] = etherQuantity;

        }
        else if (_methodSelector == REDEEM_SELECTOR) {
          (uint wad) = __decodeRedeemArgs(_encodedArgs);
          outgoingAssets_ = new address[](1);
          outgoingAssets_[0] = WETH;
          outgoingAmounts_[0] = wad;
        }
        else {
          revert("parseOutgoingAssets: _methodSelector invalid");
        }

    }

    // 3. Add your own adapter functions here. You can have one or many primary functions and helpers.


    function borrow(bytes memory _encodedArgs)
        internal
        {
          (uint etherQuantity) = __decodeBorrowArgs(_encodedArgs);
          // Convert WETH to ETH
          IWeth(WETH).withdraw(etherQuantity);
          IETHJoin(ETHJoin).join(address(this), etherQuantity);

        }

    function redeem(bytes memory _encodedArgs)
        internal
        {

          (uint wad) = __decodeRedeemArgs(_encodedArgs);
          IETHJoin(ETHJoin).exit(address(this), wad);
          // Convert ETH to WETH
          IWeth(WETH).deposit{value: wad}();

        }

    function __decodeBorrowArgs(bytes memory _encodedArgs)
        private
        pure
        returns (uint etherQuantity )
    {
        return abi.decode(_encodedArgs, (uint));
    }

    function __decodeRedeemArgs(bytes memory _encodedArgs)
        private
        pure
        returns (uint wad_)
    {
        return abi.decode(_encodedArgs, (uint));
    }

}

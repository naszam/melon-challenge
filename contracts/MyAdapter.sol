/// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

import "./IAdapter.sol";
import "./IntegrationSignatures.sol";

// 1. Rename contract, @title comment, and file to your adapter name
/// @title My Adapter contract
/// @dev This is the main file that you'll need to edit to implement your adapter's behavior
contract MyAdapter is IAdapter, IntegrationSignatures {
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

        // YOUR CODE HERE
    }

    // 3. Add your own adapter functions here. You can have one or many primary functions and helpers.

    // YOUR CODE HERE
}

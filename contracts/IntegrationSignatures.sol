/// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

/// @title Integration Signatures Contract
/// @dev Create a selector constant for each of your callable adapter methods (not including parseOutgoingAssets())
contract IntegrationSignatures {
    // 1. Create a constant for the function selectors of each of your adapter methods
    // For example:
    // bytes4 constant public TAKE_ORDER_SELECTOR = bytes4(keccak256("takeOrder(bytes)"));

    bytes4 constant public BORROW_SELECTOR = bytes4(keccak256("borrow(bytes)"));
    bytes4 constant public REDEEM_SELECTOR = bytes4(keccak256("redeem(bytes)"));
}

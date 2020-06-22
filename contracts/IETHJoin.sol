// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

/// @title IETHJoin Interface
interface IETHJoin {
  /// @dev https://etherscan.io/address/0x2f0b23f53734252bda2277357e97e1517d6b042a#code
  function join(address urn) external payable;
  function exit(address usr, uint wad) external;
}

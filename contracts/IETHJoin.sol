// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

/// @title IETHJoin Interface
interface IETHJoin {

  function join(address urn, uint eth) external;
  function exit(address usr, uint wad) external;
}

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

/// @title IWeth Interface
interface IWeth {
  /// @dev see https://github.com/dapphub/ds-weth/blob/master/src/weth9.sol#L34
  function deposit() external payable;
  function withdraw(uint wad) external;
}

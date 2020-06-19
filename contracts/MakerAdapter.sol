/// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.10;

import "./IAdapter.sol";
import "./IntegrationSignatures.sol";

interface GemLike {
    function transfer(address,uint) external returns (bool);
    function transferFrom(address,address,uint) external returns (bool);
}

interface VatLike {
    function slip(bytes32,address,int) external;
    function move(address,address,uint) external;
    function flux(bytes32,address,address,uint) external;
}

/// @title Maker Adapter contract
/// @dev This is the main file that you'll need to edit to implement your adapter's behavior
contract MakerAdapter is IAdapter, IntegrationSignatures {

      VatLike public vat;
      bytes32 public ilk;

      constructor(address vat_, bytes32 ilk_) public {
        vat = VatLike(vat_);
        ilk = ilk_;
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



    }

    // 3. Add your own adapter functions here. You can have one or many primary functions and helpers.
    /// @dev see https://github.com/makerdao/dss/blob/2ad32fdfb18d3869c88392c7c0caf1cde5302a15/src/join.sol#L84
    function join(address urn) public payable {
      require(int(msg.value) >= 0);
      vat.slip(ilk, urn, int(msg.value));
    }

    function exit(address payable usr, uint wad) public {
      address urn = msg.sender;
      require(int(wad) >= 0);
      vat.slip(ilk, urn, -int(wad));
      usr.transfer(wad);
    }
}

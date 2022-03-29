pragma solidity ^0.4.26;
 
// SPDX-License-Identifier: GPL-3.0

import "./Ownable.sol";


contract Whitelist is Ownable{


    // Indexer une adresse à un bénéficiaire
    mapping(address => bool) public whitelist;
    event AddedBeneficiary(address indexed _beneficiary);

    // Fonction verifier si un bénificiaire est déjà dans la liste
    function isWhitelisted(address _beneficiary) internal view returns (bool) {
      return (whitelist[_beneficiary]);
    }

    // Fonction ajouter un bénificiaire à la liste blanche
    function addToWhitelist(address[] _beneficiaries) public onlyOwner {
      for (uint256 i = 0; i < _beneficiaries.length; i++) {
        whitelist[_beneficiaries[i]] = true;
      }
    }

    // Fonction enlever un bénificiaire à la liste blanche 
    function removeFromWhitelist(address _beneficiary) public onlyOwner {
      whitelist[_beneficiary] = false;
    }
  }


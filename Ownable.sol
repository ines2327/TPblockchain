pragma solidity ^0.4.26;

// SPDX-License-Identifier: GPL-3.0

contract Ownable {
    // Adresse publique du propriétaire du contrat
    address public owner;  

    // Créer un evenement de transfert du contrat entre le précedent et le nouveau propriétaire
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner); 

    constructor() public {
    // Set du propriétaire 
        owner = msg.sender;
    }
    //Les modifications peuvent être faites que par le propriétaire
    modifier onlyOwner() {

    //On verifie que l'argument est bien celui du propriétaire
        require(msg.sender == owner, "Not authorized operation");
        _;
    }

    //Fonction permettant de transferer le contrat au nouveau propriétaire
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Address shouldn't be zero");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}


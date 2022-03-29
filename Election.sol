pragma solidity ^0.4.26;


// SPDX-License-Identifier: GPL-3.0

import "./Ownable.sol";
import "./SafeMath.sol";
import "./Whitelist.sol";


contract Election is Ownable {

using SafeMath for uint256;

    // Modele Candidat
    struct Candidate {
        uint256 id;         //id Candidat
        string name;        // Nom du candidat
        uint voteCount;    // Nombre de votes du candidat
    }

    // Modele Voteur
    struct Voter {
        bool authorized;   //Uniquement certaines personnes autorisées à voter
        bool voted;        //On verifie qui a voté. Un seul vote par personne
        uint vote;         // Pour qui la personne a voté
    }

    //Nom de l'election
    string public electionName; 
   
    // Ajouter un candidat
    function addCandidate(string _name) ownerOnly public {
        candidates.push(Candidate(_name, 0));       
    }

    // Nombre de candidats //
    
    function getNumCandidate() public returns(uint ) {
        return candidates.length;
    }

    // Nombre de votants
    mapping(address => bool) public voters;


    //Autoriser quelqu'un à voter
    function authorize(adress_person) ownerOnly public {
        voters[_person].authorized = true;
    }

    //Création d'un event pour le votedEvent 
    event votedEvent (address indexed _candidateId); 
    
    // Fonction voter

    function vote (uint _candidateId) public {
         // On vérifie que la personne n'a pas déjà voter
        require(!voters[msg.sender]);

        // On vérifie que la personne est bien autorisée à voter
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // On enregistre le vote de la personne
        voters[msg.sender] = true;

        // On met à jour le compteur du vote du candidat qui a eu une voix en plus
        candidates[_candidateId].voteCount ++;

        // Le nombre de vote émis par candidat
        emit votedEvent (_candidateId);

        // Incrementation du nombre total de vote 
        totalVotes += 1; 
    }

         //Terminer l'election 
    function end() ownerOnly public {
        //Destruction du contrat 
        selfdestruct(owner); 
        }

}






   


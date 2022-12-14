// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Turing is ERC20{
    address owner;
    address professor;
    bool allow_vote;
    mapping(string => address) adrs;
    mapping(address => string) adrs_reverse;

    mapping(address => mapping(address => bool)) mapVoted;
    address[] allowed_adrs;

    constructor() ERC20("Turing", "Turing"){
        allow_vote = true;
        owner = msg.sender;
        professor = 0xA5095296F7fF9Bdb01c22e3E0aC974C8963378ad;
        
        adrs["Andre"]       = 0xD07318971e2C15b4f8d3d28A0AEF8F16B9D8EAb6;
        adrs["Antonio"]     = 0x127B963B9918261Ef713cB7950c4AD16d4Fe18c6;
        adrs["Ratonilo"]    = 0x5d84D451296908aFA110e6B37b64B1605658283f;
        adrs["eduardo"]     = 0x500E357176eE9D56c336e0DC090717a5B1119cC2;
        adrs["Enzo"]        = 0x5217A9963846a4fD62d35BB7d58eAB2dF9D9CBb8;        
        adrs["Fernando"]    = 0xFED450e1300CEe0f69b1F01FA85140646E596567;
        adrs["Juliana"]     = 0xFec23E4c9540bfA6BBE39c4728652F2def99bc1e;
        adrs["Altoe"]       = 0x6701D0C23d51231E676698446E55F4936F5d99dF;
        adrs["Salgado"]     = 0x8321730F4D59c01f5739f1684ABa85f8262f8980;
        adrs["Regata"]      = 0x4A35eFD10c4b467508C35f8C309Ebc34ae1e129a;
        adrs["Luis"]        = 0xDD551702Dc580B7fDa2ddB7a1Ca63d29E8CDCf33;
        adrs["Nicolas"]     = 0x01fe9DdD4916019beC6268724189B2EED8C2D49a;
        adrs["Rauta"]       = 0x726150C568f3C7f1BB3C47fd1A224a5C3F706BB1;
        adrs["Silva"]       = 0xCAFE34A88dCac60a48e64107A44D3d8651448cd9;
        adrs["Sophie"]      = 0xDfb0B8b7530a6444c73bFAda4A2ee3e482dCB1E3;
        adrs["Thiago"]      = 0xBeb89bd95dD9624dEd83b12dB782EAE30805ef97;
        adrs["Brito"]       = 0xEe4768Af8caEeB042Da5205fcd66fdEBa0F3FD4f;
        adrs["ulopesu"]     = 0x89e66f9b31DAd708b4c5B78EF9097b1cf429c8ee;
        adrs["Vinicius"]    = 0x48cd1D1478eBD643dba50FB3e99030BE4F84d468;
        adrs["Bonella"]     = 0xFADAf046e6Acd9E276940C728f6B3Ac1A043054c;

        adrs_reverse[0xD07318971e2C15b4f8d3d28A0AEF8F16B9D8EAb6] = "Andre";
        adrs_reverse[0x127B963B9918261Ef713cB7950c4AD16d4Fe18c6] = "Antonio";
        adrs_reverse[0x5d84D451296908aFA110e6B37b64B1605658283f] = "Ratonilo";
        adrs_reverse[0x500E357176eE9D56c336e0DC090717a5B1119cC2] = "eduardo";
        adrs_reverse[0x5217A9963846a4fD62d35BB7d58eAB2dF9D9CBb8] = "Enzo";
        adrs_reverse[0xFED450e1300CEe0f69b1F01FA85140646E596567] = "Fernando";
        adrs_reverse[0xFec23E4c9540bfA6BBE39c4728652F2def99bc1e] = "Juliana";
        adrs_reverse[0x6701D0C23d51231E676698446E55F4936F5d99dF] = "Altoe";
        adrs_reverse[0x8321730F4D59c01f5739f1684ABa85f8262f8980] = "Salgado";
        adrs_reverse[0x4A35eFD10c4b467508C35f8C309Ebc34ae1e129a] = "Regata";
        adrs_reverse[0xDD551702Dc580B7fDa2ddB7a1Ca63d29E8CDCf33] = "Luis";
        adrs_reverse[0x01fe9DdD4916019beC6268724189B2EED8C2D49a] = "Nicolas";
        adrs_reverse[0x726150C568f3C7f1BB3C47fd1A224a5C3F706BB1] = "Rauta";
        adrs_reverse[0xCAFE34A88dCac60a48e64107A44D3d8651448cd9] = "Silva";
        adrs_reverse[0xDfb0B8b7530a6444c73bFAda4A2ee3e482dCB1E3] = "Sophie";
        adrs_reverse[0xBeb89bd95dD9624dEd83b12dB782EAE30805ef97] = "Thiago";
        adrs_reverse[0xEe4768Af8caEeB042Da5205fcd66fdEBa0F3FD4f] = "Brito";
        adrs_reverse[0x89e66f9b31DAd708b4c5B78EF9097b1cf429c8ee] = "ulopesu";
        adrs_reverse[0x48cd1D1478eBD643dba50FB3e99030BE4F84d468] = "Vinicius";
        adrs_reverse[0xFADAf046e6Acd9E276940C728f6B3Ac1A043054c] = "Bonella";
    }

    modifier onlyProf {
        require(msg.sender == professor);
        _;
    }

    modifier voteEspecifier(string memory name, uint256 amount) {
        require(msg.sender != adrs[name], "Sender can't vote for itself");                     // não vota em si
        require(amount < 2 ether, "Amount must be smaller than 2 ether");                      // quantidade maxima
        require(allow_vote == true, "Poll closed");                                            // a votação não foi encerrada
        require(!mapVoted[msg.sender][adrs[name]], "Sender has already voted to that person"); // ainda não votou na pessoa
        require(bytes(adrs_reverse[msg.sender]).length > 0, "Sender not available to vote");   // sender autorizado
        require(adrs[name] != address(0), "Address unknown");                                  // codinome autorizado
        _;
    }

    function issueToken(address receiver, uint256 amount) public onlyProf {
        _mint(receiver, amount);
    }

    function vote(string memory codinome, uint256 amount) public voteEspecifier(codinome, amount){
        _mint(adrs[codinome], amount);
        _mint(msg.sender, 2*10**17);
        mapVoted[msg.sender][adrs[codinome]] = true;
    }

    function endVoting() public onlyProf {
        allow_vote = !allow_vote;
    }
}

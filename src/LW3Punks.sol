// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable {
    using Strings for uint256;
    /**
     *@dev _baseTokenURI for computing {tokenURL}. If set, the resulting URL for each token will be concatenation of the `baseURI` and the `tokenId`.
     */
    string _baseTokenURI;

    // _price is the price of one LW3Punks NFT
    uint256 public _price = 0.01 ether;

    // _paused is used to pause the contract in case of an emergency
    bool public _paused;

    // max number of LW3Punks
    uint256 public maxTokenIds = 10;

    // total number of tokenIds minted;
    uint256 public tokenIds;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    /**
        * @dev ERC721 constructor takes in a `name` and a `symbol` to the token collection.
        * name in our case is `LW3Punks` and symbol is `LW3P`.
        * Constructor for LW3P takes in the baseURI to set _baseTokenURI for the collection.
        */
    constructor (string memory baseURI) ERC721("LW3Punks", "LW3P") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }    

    /**
     * @dev mint allows user to mint 1 NFT per transaction.
     */
    function mint() public payable onlyWhenNotPaused {
        require(tokenIds < maxTokenIds, "Exceeds maximum LW3Punks supply");
        require(msg.value >= _price, "Ether sent is not correct");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }
}
// SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdtoUri;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    //How to mint NFT
    function mintNft(string memory tokenUri) public {
        s_tokenIdtoUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); //This will increases their balance
        s_tokenCounter++;
    }

    //This will help us see how the NFT actually looks like
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdtoUri[tokenId];
    }

    /**Getter Function */
    function getTokenCounter() external returns(uint256){
        return s_tokenCounter;
    }
}

/**
 * NOTE
 * TokenURI is the full form for Token Uniform Resource Indentifier
 * A URI identifies the resource by name at the specified location or URL, It is actually like an endpoint which will return the metadata of the NFT
 *
 */

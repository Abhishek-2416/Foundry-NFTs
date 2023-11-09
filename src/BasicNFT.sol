// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract BasicNFT is ERC721 {
    /**
     * @dev We are going to represent each token counter as its tokenId
     */
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdtoUri;

    constructor() ERC721("Dogie","DOG"){
        s_tokenCounter = 0;
    }

    /**
     * @notice Our mint function will allow people to actually choose their own tokenURI
     * This will mint the NFT and send it to the msg.sender, In this we use custom tokenUri
     */
    function mintNft(string memory tokenUri) public {
        s_tokenIdtoUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenCounter++;
    }

    /**
     * The URI identifies the resource by name at the specified location or URL
     * @dev This will return a metadata for the NFT
     * @notice This will tell us how the NFT is gonna look and its functions
     */
    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return s_tokenIdtoUri[tokenId];
    }
}
// SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721{
    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        Happy,
        Sad
    }

    mapping(uint256 => Mood) name;

    constructor(string memory sadSvgImageUri,string memory happySvgImageUri)ERC721("Mood NFT","MN"){
        s_tokenCounter = 0;
        sadSvgImageUri = s_sadSvgImageUri;
        happySvgImageUri = s_happySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenCounter++;
    }

    // function tokenURI(uint256 tokenId) public view override returns(string memory){
    //     return string(
    //             abi.encodePacked(
    //                 _baseURI(),
    //                 Base64.encode(
    //                     bytes(
    //                         abi.encodePacked(
    //                             '{"name":"',
    //                             name(), // You can add whatever name here
    //                             '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
    //                             '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                
    //                             '"}'
    //                         )
    //                     )
    //                 )
    //             )
    //         );
    // }
    
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MoodNFT is ERC721 {
    //Errors
    error MoodNFT__CannotFlipMoodIfNotOwner();

    //State Variables
    uint256 private s_tokenCounter;
    string private s_sadSvgImageURI;
    string private s_happySvgImageURI;

    enum Mood{Happy,Sad}

    mapping(address => uint256) private s_TokenIdToOwner;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvgImageURI,string memory happySvgImageURI) ERC721("Mood NFT","MN"){
            s_sadSvgImageURI = sadSvgImageURI;
            s_happySvgImageURI = happySvgImageURI;
            s_tokenCounter = 0;
    }

    /**
     * @notice Making it so that everyone can mint one of these
     */
    function mintNft() public {
        _safeMint(msg.sender,s_tokenCounter);
        s_TokenIdToOwner[msg.sender] = s_tokenCounter;
        s_tokenIdToMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        //Only want the NFT owner to change the mood 
        if(s_TokenIdToOwner[msg.sender] != tokenId){
            revert MoodNFT__CannotFlipMoodIfNotOwner();
        }
        if(s_tokenIdToMood[tokenId] == Mood.Happy){
            s_tokenIdToMood[tokenId] = Mood.Sad;
        }else {
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }
    }

    function _baseURI() internal pure override returns(string memory) {
        return "data:application/json;base64,";
    }

    /**
     * @notice This is to define how the NFT is going to be or what the NFT Looks like
     */
    function tokenURI(uint256 tokenId) public view override returns(string memory imageURI){
        if(s_tokenIdToMood[tokenId] == Mood.Happy){
            imageURI = s_happySvgImageURI;
        }else {
            imageURI = s_sadSvgImageURI;
        }

        /**
         * Doing this is basicially writing base64 -i sad.svg so that giant peace of string is this 
         * @dev Now we directly cannot add it into the browser so for that we need to do that we have to concatinate _baseURI()
         */
        string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                    abi.encodePacked (
                        '{"name":"',
                        name(), // You can add whatever name here
                        '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                        '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                        imageURI,
                        '"}'
                        )
                    )
                )
            )
        );
    }
}
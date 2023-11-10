// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";

contract TestBasicNFT is Test{
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;

    //Making addresses
    address bob = makeAddr("bob");

    //State Variables
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    /**
     * @notice In this we are checking if the name of the nft is correct or not
     * @dev We do this by get hashes of both the strings and then comparing them
     */
    function testTheNameIsCorrect() external {
        string memory expectedName = "Dogie";
        string memory actualName = basicNFT.name();
        assertEq(
            keccak256(abi.encodePacked(expectedName)),
            keccak256(abi.encodePacked(actualName))
        );

        //OR 

        assertEq(
            keccak256(bytes(expectedName)),
            keccak256(bytes(actualName))
        );
    }

    function testTheSymbolIsCorrect() external {
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNFT.symbol();
        assertEq(
            keccak256(abi.encodePacked(expectedSymbol)),
            keccak256(abi.encodePacked(actualSymbol))
        );
    }

    /**
     * @notice Here we are checking if it can Mint and NFT and the NFT gets shown in the user account
     * @dev In this first we mint a basic NFT and check if the balance of user increases
     * We also check if the it has the same NFT which we minted or no
     */
    function testCanMintAndHaveBalance() external {
        vm.prank(bob);
        basicNFT.mintNft(PUG);

        //Checking If the balance Increases
        assertEq(basicNFT.balanceOf(bob),1);

        //Checking if the same NFT was minted
        assertEq(
            keccak256(abi.encodePacked(PUG)),
            keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
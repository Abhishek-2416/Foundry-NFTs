// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;

    //Addresses
    address public bob = makeAddr("bob");

    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testName() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        assert(
            keccak256(abi.encodePacked(actualName)) ==
                keccak256(abi.encodePacked(expectedName))
        );
    }

    function testSymbol() public view {
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNft.symbol();

        assert(
            keccak256(abi.encodePacked(actualSymbol)) ==
                keccak256(abi.encodePacked(expectedSymbol))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(bob);
        basicNft.mintNft(PUG);

        assertEq(basicNft.balanceOf(bob), 1);
        assertEq(
            keccak256(abi.encodePacked(PUG)),
            keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}

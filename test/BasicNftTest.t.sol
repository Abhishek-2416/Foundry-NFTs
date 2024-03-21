// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;

    string public constant PUG = "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";

    //addresses
    address bob = makeAddr("bob");

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory actualName = basicNft.name();
        string memory expectedName = "Doggie";

        assertEq(keccak256(abi.encodePacked(actualName)), keccak256(abi.encodePacked(expectedName)));
    }

    function testSymbolIsCorrect() public view {
        string memory actualSymbol = basicNft.symbol();
        string memory expectedSymbol = "DOG";

        assertEq(keccak256(abi.encodePacked(actualSymbol)), keccak256(abi.encodePacked(expectedSymbol)));
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(bob);
        basicNft.mintNft(PUG);
        assertEq(basicNft.balanceOf(bob), 1);
        assertEq(keccak256(abi.encodePacked(PUG)), keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}

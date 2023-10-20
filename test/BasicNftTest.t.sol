// SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicsNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract TestBasicNft is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;
    string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    address public USER = makeAddr("user");

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        //String are special array of bytes so we cannot do actualnName == expectedName
        assertEq(actualName, expectedName); //We can either do this

        //Or we can do it we can take the hash of both the string and check their hashes , they should be equal
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testSymbolIsCorrect() public{
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNft.symbol();

        assertEq(expectedSymbol,actualSymbol);
    }

    function testCanMintAndHaveABalance() public{
        vm.prank(USER);
        basicNft.mintNft(PUG);

        //Checking if balance has increased
        assertEq(basicNft.balanceOf(USER),1);
        assertEq(PUG,basicNft.tokenURI(0));
    }
}

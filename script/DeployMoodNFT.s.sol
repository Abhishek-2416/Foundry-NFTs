// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    
    function run() external returns(MoodNFT) {
        //We are using the readFile from foundry which lol readfiles but before that we need to add fs_permissions in foundry.toml
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();
        return moodNFT;
    }

    /**
     * @dev Here it will automatically convert the svg code to the Image URI
     * @param svg Here we need to enter the svg of the image we want to convert into ImageURI
     */
    function svgToImageURI(string memory svg) public pure returns(string memory) {
        //This is going to be the prefix
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        //We can use encodePacked for even concatination strings
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }
}
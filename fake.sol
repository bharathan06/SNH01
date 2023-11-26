// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FakeProduct {
    struct Product {
        string itemname;
        string brand;
        uint256 exp;
        uint256 cost;
    }

    mapping(uint256 => Product) public items;
    uint256 public number;
    uint256 public lastItemId;
    uint256 self = 143;

    event itemCreated(uint256 indexed id, string brand, string itemname, uint256 exp, uint256 cost);

    constructor() {
        number = 0;
        lastItemId = 0;
    }

    function Createitem(string memory itemname, string memory brand, uint256 exp, uint256 cost) public {
        uint256 id = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, number, self,cost,exp)));
        items[id] = Product(itemname, brand, exp, cost);
        emit itemCreated(id, itemname, brand, exp , cost);
        number++;
        lastItemId = id; 
    }
    function getLastItemId() public view returns (uint256) {
        return lastItemId;
    }
    function checkproduct(uint256 id) public view returns (Product memory) {
        require(id != 0, "Invalid id");
        return items[id];
    }

    function check(uint256 id) public view returns (bool) {
        return items[id].exp != 0;
    }
}

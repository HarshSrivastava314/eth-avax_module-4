// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FinalGame {
    string public name;
    string public symbol;
    address public owner;

    mapping(address => bool) private Car;
    mapping(address => bool) private Plane;
    mapping(address => bool) private Bike;
    mapping(address => bool) private Cycle;
    mapping(address => uint256[4]) private redeemedItems;

    mapping(address => uint256) private balances;

    constructor() {
        name = "Degen";
        symbol = "DGN";
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function mint(address account, uint256 amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        balances[account] += amount;
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        return true;
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
    }
    
    function showRedeemableItems() public pure returns (string memory) {
        return "1. Car(100 AVAX)  2. Plane(100 AVAX)  3. Bike(30 AVAX)  4. Cycle(50 AVAX)";
    }

    function redeemToken(uint256 item, uint256 quantity) public {
        require(quantity > 0, "Quantity must be greater than zero");

        if (item == 1) {
            redeemTShirt(quantity);
        } else if (item == 2) {
            redeemPlane(quantity);
        } else if (item == 3) {
            redeemBike(quantity);
        } else if (item == 4) {
            redeemCycle(quantity);
        } else {
            revert("Invalid item");
        }
    }

    function redeemTShirt(uint256 quantity) private {
        uint256 requiredBalance = 100 * quantity;
        require(balances[msg.sender] >= requiredBalance, "Insufficient balance for Car redemption");
        require(!Car[msg.sender], "Car already redeemed");

        Car[msg.sender] = true;
        balances[msg.sender] -= requiredBalance;
        redeemedItems[msg.sender][0] += quantity;
        // Add additional logic for granting the Car item(s) to the player
    }

    function redeemPlane(uint256 quantity) private {
        uint256 requiredBalance = 100 * quantity;
        require(balances[msg.sender] >= requiredBalance, "Insufficient balance for Plane redemption");
        require(!Plane[msg.sender], "Plane already redeemed");

        Plane[msg.sender] = true;
        balances[msg.sender] -= requiredBalance;
        redeemedItems[msg.sender][1] += quantity;
        // Add additional logic for granting the Plane item(s) to the player
    }

    function redeemBike(uint256 quantity) private {
        uint256 requiredBalance = 30 * quantity;
        require(balances[msg.sender] >= requiredBalance, "Insufficient balance for Bike redemption");
        require(!Bike[msg.sender], "Bike already redeemed");

        Bike[msg.sender] = true;
        balances[msg.sender] -= requiredBalance;
        redeemedItems[msg.sender][2] += quantity;
        // Add additional logic for granting the Bike item(s) to the player
    }

    function redeemCycle(uint256 quantity) private {
        uint256 requiredBalance = 50 * quantity;
        require(balances[msg.sender] >= requiredBalance, "Insufficient balance for Cycle redemption");
        require(!Cycle[msg.sender], "Cycle already redeemed");

        Cycle[msg.sender] = true;
        balances[msg.sender] -= requiredBalance;
        redeemedItems[msg.sender][3] += quantity;
        // Add additional logic for granting the Cycle item(s) to the player
    }

    function checkBalance(address account) public view returns (uint256) {
        return balances[account];
    }

    function showRedeemedItems(address account) public view returns (string memory) {
        string[4] memory itemNames = ["Car", "Plane", "Bike", "Cycle"];
        string memory result = "";

        for (uint256 i = 0; i < itemNames.length; i++) {
            if (i > 0) {
                result = string(abi.encodePacked(result, "\n"));
            }
            result = string(
                abi.encodePacked(result, itemNames[i], ": ", toString(redeemedItems[account][i]), " items")
            );
        }

        return result;
    }

    function toString(uint256 value) private pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint256 temp = value;
        uint256 digits;

        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);

        for (uint256 i = digits; i > 0; i--) {
            buffer[i - 1] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }

        return string(buffer);
    }
}

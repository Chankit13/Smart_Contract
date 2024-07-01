// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleContract {
    address private owner;
    uint public balance;

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    function deposit(uint amount) public {
        // Require that the amount is greater than 0
        require(amount > 0, "Amount must be greater than 0");

        // Add the amount to the balance
        balance += amount;
    }

    function withdraw(uint amount) public {
        // Require that the balance is not zero
        require(balance > 0, "Balance is zero");

        // Require that the amount is less than or equal to the balance
        require(amount <= balance, "Insufficient balance");

        // Subtract the amount from the balance
        balance -= amount;
    }

    function emergencyWithdraw() public {
        // Revert if the caller is not the owner
        require(msg.sender == owner, "Only the owner can perform an emergency withdraw");

        // Set the balance to 0
        balance = 0;
    }
}

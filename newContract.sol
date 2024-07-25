// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleContract {
    address private owner;
    uint public balance;

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    // Modifier to check if the caller is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Modifier to check if the amount is greater than 0
    modifier validAmount(uint amount) {
        require(amount > 0, "Amount must be greater than 0");
        _;
    }

    // Event to log deposits
    event Deposit(address indexed from, uint amount);

    // Event to log withdrawals
    event Withdrawal(address indexed to, uint amount);

    function deposit(uint amount) public validAmount(amount) {
        // Add the amount to the balance
        balance += amount;

        // Emit the deposit event
        emit Deposit(msg.sender, amount);
        
        // Use assert to check the balance invariance
        assert(balance >= amount);
    }

    function withdraw(uint amount) public {
        // Use require to ensure the balance is not zero
        require(balance > 0, "Balance is zero");

        // Use require to check if the amount is less than or equal to the balance
        require(amount <= balance, "Insufficient balance");

        // Subtract the amount from the balance
        balance -= amount;

        // Emit the withdrawal event
        emit Withdrawal(msg.sender, amount);

        // Use assert to check the balance invariance
        assert(balance >= 0);
    }

    function emergencyWithdraw() public onlyOwner {
        // Use assert to ensure the owner is performing the operation
        assert(msg.sender == owner);

        // Set the balance to 0
        balance = 0;

        // Emit the withdrawal event
        emit Withdrawal(msg.sender, balance);
    }

    function testRevert() public pure {
        // Example of using revert
        if (true) {
            revert("This is a revert example");
        }
    }
}

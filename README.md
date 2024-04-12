# One click fungi stabilizooooor

This smart-contract is your easy single-click fungi stabilizor.

There are three functions:
1. `stabilize(uint256 amount)`: stabilizes a single amount of $FUNGI. The contract will transfer some $FUNGI from your account to the contract, and immediately send it back to you, stabilizing the newly created inscription!
2. `stabilizeMultiple(uint256[] amounts, uint256 balance)`: stabilizes different amounts of $FUNGI in a single transaction. Works just like `stabilize` but allows you to stabilize MULTIPLE inscriptions at once!
3. `combineMultiple(uint256[] amounts)`: allows a user to send combine multiple inscriptions into two different inscriptions.

Keep in mind, you need to have approved the contract before!
# eth-avax_module-4

FinalGame Contract

License This contract is using the MIT License.

Prerequisites Solidity ^0.8.0

Contract Details The contract is named FinalGame. The name and symbol variables store the name and symbol of the token, respectively. The owner variable stores the address of the contract owner. These mappings keep track of which items (T-shirt, Pants, Cap, Shoes) have been redeemed by each address (msg.sender). The redeemedItems mapping stores the quantity of each item redeemed by each address. The balances mapping stores the token balances of each address. The constructor initializes the name and symbol variables as "GameMoney" and "GM", respectively. It also sets the owner to be the address that deploys the contract. The onlyOwner modifier restricts certain functions to be called only by the contract owner. The mint function allows the contract owner to mint new tokens and assign them to a specified account. The transfer function allows users to transfer tokens from their own address to a specified recipient. The showRedeemableItems function returns a string listing the redeemable items and their respective token amounts. The redeemToken function is used to redeem an item by providing the item ID and the desired quantity. It checks the quantity, and based on the item ID, calls the respective private redemption function. The redeemTShirt function is a private function called by redeemToken to redeem T-shirts. It checks the balance, ensures the T-shirt hasn't been redeemed before, deducts the required tokens, and updates the redeemed items mapping. The checkBalance function allows users to check their token balance by providing their account address. The showRedeemedItems function returns a string that displays the items redeemed by a specific account and their respective quantities. The toString function is a utility function that converts a uint256 value to a string representation.

Video walkthrough

https://www.loom.com/share/e472aab4778943cda564241fd1360f7c

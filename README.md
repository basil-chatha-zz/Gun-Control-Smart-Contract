# GunToken

## Introduction
In response to ever-increasing national gun violence and a lack of proper verification systems for gun ownership, we propose the creation of a decentralized platform that allows for instant verification of gun owner’s identity as well as the ability to track the lifecycle of a gun from manufacture to current owner. This platform allows government officials to tie gun ownership to a person’s identity, thereby making gun incidents easier to track.

Our system would essentially act as an “electronic gun safe”, comparable to a crypto-owner’s digital wallet. The information about an owner’s gun would have to be accessed via some form of digital verification, be it a QR code, fingerprint or retina scan. The safes themselves would contain gun-specific information about a specific firearm, transferable after a gun is involved in a transaction.

In accordance with our DApp design choices, each gun is tagged with a non-fungible token stored in a publicly decentralized database according to the ERC721 token primitive standard. ERC721 allows for the minting of tokens by the contract deployer (in this case, the government) and allows for tangible assets to be tracked by digital assets. Even though each gun is attached to an owner’s address rather than their identity, it still allows public officials to track who owns what gun simply by querying the blockchain from an administrator account.

## Instructions to Run
1. Go to [Remix](https://remix.ethereum.org/#optimize=false&version=soljson-v0.5.1+commit.c8a2cb62.js), an online IDE for developing Ethereum smart contracts
2. Delete any default files by exiting out of them
3. In the top left, click the plus button and add a file called "GunControl.sol"
4. Copy the code in the GunControl.sol file in this repository into that file
5. Create another file called "GunOwnership.sol" and do the same with that file in this repository
6. In the "Compile" tab in the top right, click on "Select a compiler version" and make sure it is on 0.5.7
7. Click "Start to compile" - there should be no errors
8. Go to the "Run" tab - again in the top right of the screen adjacent to the "Compile" tab
9. Click the "Environment" dropdown and click "Javascript VM"
10. Click "GunOwnership" in the dropdown menu directly above the "deploy" button
11. Click "deploy"
12. Create a contract by going to the newly deployed contract under "Deployed Contracts" and running the \_createToken function
13. To see which account currently owns the newly created gun, go to the gunIndexToOwner function and type "0" in as the parameter (all guns in the contract are stored in an array, so the first gun has index 0 in the array) - the returned address should be the one that created the gun
14. To see how transferring the gun works, you (the address that created the token) must go into the approve function and input the address of the gun you want to transfer it to and its index in the array (for this test, 0). You should see that if you try to approve the gun for any address other than the one that created the gun, you will get an error
15. Once the gun is approved for the new owner address, change your address by hitting the dropdown menu called "Account", right below the "Environment" dropdown we used earlier
16. As the address that will receive the gun now, run the transferFrom function and input the address of the previous gun owner, the new address you just changed to, and the gun id you would like to transfer (0 in this case) - you'll see that if you try to transfer the gun from any other account than the one who was approved to receive it, you will get an error
17. To actually see if the gun was transferred, go back and input the gun id into the gunIndexToOwner function - the address returned should be the new owner

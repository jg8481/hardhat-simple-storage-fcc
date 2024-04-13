These are my notes while working on [Patrick's Javascript Blockchain/Smart Contract FreeCodeCamp Course](https://www.youtube.com/watch?v=gyMwXuJrbJQ).

- On April 7, 2024 successfully compiled and deployed the following "Hardhat smart contract deployment and local Hardhat Node" example code to interact with a locally installed Hardhat fake blockchain node. I made a lot of changes to Patrick's original deployment code, and also included a Fantom mainnet forking script to create a local Fantom Hardhat Node deployment.
![alt text](./notes/image1.png)

- On April 7, 2024 I also created enhancements to Patrick's tests to make them into a datadriven library that can be used by other automation frameworks.
![alt text](./notes/image2.png)

- On April 7, 2024 I also created an enhanced Hardhat automation pipeline script that stops an Ethereum Testnet deployment if any test failures are detected. This automation pipeline script will work exactly the same for an Ethereum Mainnet deployment.

Build pipeline success example:
![alt text](./notes/image3.png)

Build pipeline failure example:
![alt text](./notes/image4.png)

Here is one of several contracts I deployed with this build pipeline to Sepolia Testnet using my own Alchemy Sepolia Testnet RPC.
  - https://sepolia.etherscan.io/address/0x283dc8314ff2b950ec4bf2b6dcfdbb1c67bca073

---
### Technical Requirements

Check the basic technical requirements from Patrick's original GitHub repo. For convenience, MacOS users can run `bash ./Lesson6CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux` from the root of this repo to help quickly install the required tools.

### Quick Start Script

After the basic technical requirements are installed and working, then you can run the `bash ./Lesson6CodeSessions_start-automation-build-pipeline.sh` script. This automation script will start a sequence of the scripts listed below, and is meant to behave like a typical build pipeline.

### Current Toolkit Capabilities
```
You can view just this help menu again (without triggering any automation) by running 'bash ./Lesson6CodeSessions_start-deployment-scripts.sh -h' or 'bash ./Lesson6CodeSessions_start-deployment-scripts.sh -h --help'.

bash ./Lesson6CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-Clean-Environment
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Hardhat
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Default-Hardhat-Node
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Forked-Fantom-Mainnet
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Real-Ethereum-Testnet
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Datadriven-Hardhat-Test

If you're running this for the first time run the following before running Start-Deployment-On-Local-Hardhat-Node.

bash ./Lesson6CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Hardhat

Then you can run the following combined commands in your terminal to deploy the contract to the Ganache local blockchain node.

bash ./Lesson6CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes && bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Hardhat-Node
```

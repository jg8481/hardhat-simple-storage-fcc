// imports
const { ethers, run, network } = require("hardhat")

// async main
async function main() {
  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
  console.log("Deploying contract...")
  const simpleStorage = await SimpleStorageFactory.deploy()

  // Not working in version 6^ ethers ----->
  
  // await simpleStorage.deployed()
  // console.log(`Deployed contract to: ${simpleStorage.address}`)

  //______________________________________________
  
  // what happens when we deploy to our hardhat network?
  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
    console.log("Waiting for block confirmations...")
    await new Promise(resolve => setTimeout(resolve, 10000)) // This will pause for a few seconds.

    // Not working in version 6^ ethers ----->
    
    // await simpleStorage.deploymentTransaction().wait(6)
    // Note from Josh: I had to disable this line above because it kept displaying an error from my terminal.

    //await verify(simpleStorage.target, [])
    // Note from Josh: I had to disable this line above because it kept displaying an error from my terminal.

    //______________________________________________

    
  }

  const currentValue = await simpleStorage.retrieve()
  console.log(`Current Value is: ${currentValue}`)

  // Update the current value
  const transactionResponse = await simpleStorage.store(7)
  await transactionResponse.wait(1)
  const updatedValue = await simpleStorage.retrieve()
  console.log(`Updated Value is: ${updatedValue}`)
}

// async function verify(contractAddress, args) {
// const verify = async (contractAddress, args) => {
//   console.log("Verifying contract...")
//   try {
//     await run("verify:verify", {
//       address: contractAddress,
//       constructorArguments: args,
//     })
//   } catch (e) {
//     if (e.message.toLowerCase().includes("already verified")) {
//       console.log("Already Verified!")
//     } else {
//       console.log(e)
//     }
//   }
// }
// Note from Josh: I had to disable this "const verify = async (contractAddress, args)..." code block above because it kept displaying an error from my terminal.

// main
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })

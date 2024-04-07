const { ethers } = require("hardhat")
const { expect, assert } = require("chai")
require("dotenv").config()

describe("SimpleStorage", function () {
  let simpleStorageFactory, simpleStorage

  beforeEach(async function () {
    simpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
    simpleStorage = await simpleStorageFactory.deploy()
  })

  it("Should start with a favorite number set by the user", async function () {
    const currentValue = await simpleStorage.retrieve()
    const expectedValue = process.env.expectedValue1 || "0"; // User or automation script gives a value from the terminal, or it defaults to "0". I expect this to fail on any value other than "0".
    assert.equal(currentValue.toString(), expectedValue)
    console.log(`          ---->>>> Contents of the "expectedValue" argument: ${expectedValue}`)
  })
  it("Should update when we call store", async function () {
    const expectedValue = process.env.expectedValue2 || "7"; // User or automation script gives a value from the terminal, or it defaults to "7".
    const transactionResponse = await simpleStorage.store(expectedValue)
    await transactionResponse.wait(1)
    const currentValue = await simpleStorage.retrieve()
    assert.equal(currentValue.toString(), expectedValue)
    console.log(`          ---->>>> Contents of the "expectedValue" argument: ${expectedValue}`)
  })

  it("Should work correctly with the people struct and array", async function () {
    const expectedPersonName = process.env.expectedPersonName || "Josh"; // User or automation script gives a value from the terminal, or it defaults to "Josh"
    const expectedFavoriteNumber = process.env.expectedFavoriteNumber || "222"; // ser or automation script gives a value from the terminal, or defaults to "222"
    const transactionResponse = await simpleStorage.addPerson(
      expectedPersonName,
      expectedFavoriteNumber
    )
    await transactionResponse.wait(1)
    const { favoriteNumber, name } = await simpleStorage.people(0)
    assert.equal(name, expectedPersonName)
    assert.equal(favoriteNumber, expectedFavoriteNumber)
    console.log(`          ---->>>> Contents of the "expectedPersonName" argument: ${expectedPersonName}`)
    console.log(`          ---->>>> Contents of the "expectedFavoriteNumber" argument: ${expectedFavoriteNumber}`)
  })
})

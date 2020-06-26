const { ethers } = require("ethers")
const Ganache = require("ganache-core")
const { accounts, contract } = require('@openzeppelin/test-environment');


const MAINNET_NODE_URL = ""
const PRIV_KEY = ""

const startChain = async () => {
  const ganache = Ganache.provider({
    fork: MAINNET_NODE_URL,
    network_id: 1,
    accounts: [
      {
        secretKey: PRIV_KEY,
        balance: ethers.utils.hexlify(ethers.utils.parseEther("1000")),
      },
    ],
  })

  const provider = new ethers.providers.Web3Provider(ganache)
  const wallet = new ethers.Wallet(PRIV_KEY, provider)

  return wallet
}

jest.setTimeout(100000)
const uniswap = require("@studydefi/money-legos/uniswap")
const erc20 = require("@studydefi/money-legos/erc20")
const MakerAdapter = contract.fromArtifact('MakerAdapter');
const SimpleVault = contract.fromArtifact('SimpleVault');

describe("do some tests", () => {
  let wallet

  beforeAll(async () => {
    wallet = await startChain()

  })

  test("initial WETH balance of 0", async () => {

    const weth = new ethers.Contract(
      erc20.weth.address,
      erc20.weth.abi,
      wallet
    )

    const wethBalanceWei = await weth.balanceOf(wallet.address)
    const wethBalance = ethers.utils.formatUnits(wethBalanceWei, 18)
    expect(parseFloat(wethBalance)).toBe(0)
  })

  test("initial ETH balance of 1000 ETH", async () => {
    const ethBalanceWei = await wallet.getBalance()
    const ethBalance = ethers.utils.formatEther(ethBalanceWei)
    expect(parseFloat(ethBalance)).toBe(1000)
  })


  test("deposit WETH", async () => {

    const wethContract = new ethers.Contract(
      erc20.weth.address,
      erc20.weth.abi,
      wallet
    )

    await wethContract.deposit({
    value: ethers.utils.parseEther("1.0"),
    gasLimit: 1000000,
    })


    const wethBal = await wethContract.balanceOf(wallet.address)

    console.log(`WETH Balance: ${ethers.utils.formatEther(wethBal)}`)
  })


})

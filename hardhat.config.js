require("@matterlabs/hardhat-zksync-solc");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: '0.8.9',
    defaultNetwork: 'goerli', // Set your desired default network
    networks: {
      hardhat: {}, // Leave this for Hardhat's local network
      goerli: {
        url: 'https://rpc.ankr.com/eth_goerli', // Provide your preferred Goerli RPC URL
        accounts: [`0x${process.env.PRIVATE_KEY}`], // Use your private key here
      },
      // Add more network configurations if needed
    },
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    artifacts: "./artifacts-zk",
    cache: "./cache-zk",
    sources: "./contracts",
    tests: "./test",
  }
};

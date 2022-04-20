require("@nomiclabs/hardhat-waffle");
const fs =  require("fs")
const privateKey = fs.readFileSync(".secret").toString()



module.exports = {
  solidity: '0.8.4',
  networks: {
    hardhat: {
      chainId: 1337,
    },
  },
  mumbai: {
    url: `https://polygon-mumbai.g.alchemy.com/v2/ZbUKcm0f1nnQvYkkBCUkyKRNzwPbdPIK`,
    accounts: [privateKey],
  },
};

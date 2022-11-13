import "@nomicfoundation/hardhat-toolbox";
import { HardhatUserConfig } from "hardhat/config";
require("dotenv").config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.17",
  },
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      accounts: [process.env.PRIV_KEY as string],
    },
  },
  etherscan: {
    apiKey: process.env.API_KEY as string,
  },
};

export default config;

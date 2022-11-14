import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract } from "@ethersproject/contracts";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import * as chai from "chai";
import chaiAsPromised from "chai-as-promised";
chai.use(chaiAsPromised);
import { keccak256 } from "ethers/lib/utils";

const parseEther = (amount: Number) => {
  return ethers.utils.parseUnits(amount.toString(), 18);
};

describe("Vault", () => {
  let owner: SignerWithAddress,
    alice: SignerWithAddress,
    bob: SignerWithAddress,
    carol: SignerWithAddress;

  let vault: Contract;
  let token: Contract;

  beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, alice, bob, carol] = await ethers.getSigners();

    const Vault = await ethers.getContractFactory("Vault", owner);
    vault = await Vault.deploy();
    const Token = await ethers.getContractFactory("Foxxy", owner);
    token = await Token.deploy();
    await vault.setToken(token.address);
  });

  // Happy case
  it("Should deposit into the Vault", async () => {
    await token.transfer(alice.address.parseEther());
  });
});

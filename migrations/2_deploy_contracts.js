var DaksToken = artifacts.require("./DaksToken.sol");
var DaksNFT = artifacts.require("./DaksNFT.sol");
require("dotenv").config({ path: "../.env" });
module.exports = async function (deployer) {
  await deployer.deploy(DaksToken, process.env.Initial_Tokens);
  let Tokeninstance = await DaksToken.deployed();
  await deployer.deploy(DaksNFT, Tokeninstance.address);
};

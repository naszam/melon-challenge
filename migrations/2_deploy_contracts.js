const SimpleVault = artifacts.require('SimpleVault');
const MakerAdapter = artifacts.require('MakerAdapter');

module.exports = async deployer => {
  await deployer.deploy(SimpleVault);
  await deployer.deploy(MakerAdapter);
}

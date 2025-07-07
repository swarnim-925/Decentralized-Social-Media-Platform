
const hre = require("hardhat");

async function main() {
  const Social = await hre.ethers.getContractFactory("DecntralizedSocialMediaPlatform");
  const social = await Social.deploy();

  await social.deployed();

  console.log("DecntralizedSocialMediaPlatform deployed to:", social.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

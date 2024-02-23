import { ethers } from "hardhat";

async function main() {

  const Poll = await ethers.deployContract("PollFactory");

  await Poll.waitForDeployment();

  console.log(
    `PollFactory deployed to ${Poll.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

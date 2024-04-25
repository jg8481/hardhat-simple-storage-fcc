#! /bin/bash

clear
TIMESTAMP=$(date)

if [ "$1" == "Stop-Local-Blockchain-Nodes-Clean-Environment" ]; then
  echo
  echo "------------------------------------[[[[ Stop-Local-Blockchain-Nodes-Clean-Environment ]]]]------------------------------------"
  echo
  echo "This command will stop any locally running network nodes and clean up any logs leftover from old runs. Feel free to run this command multiple times to clean up files listed below. This run started on $TIMESTAMP."
  echo
  killall yarn > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall node > /dev/null 2>&1
  pkill yarnn > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  ps aux | grep node
  rm -rf ./logs/*.log
  npx hardhat clean
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Install-Tools-On-MacOS-Or-Linux" ]; then
  echo
  echo "------------------------------------[[[[ Install-Tools-On-MacOS-Or-Linux ]]]]------------------------------------"
  echo
  echo "This command will install all of the required Node.js packages. This script was created on MacOS, but can be used in any Linux Distro that has curl installed. This run started on $TIMESTAMP."
  echo
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash &&
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install 18
  nvm use 18
  nvm alias default 18
  node --version
  npm install npm --global --silent
  npm update --silent
  npm install yarn -g --silent
  npm update --silent
  yarn info 2> >(grep -v warning 1>&2)
  yarn 2> >(grep -v warning 1>&2)
  yarn hardhat 2> >(grep -v warning 1>&2)
  ## If there are no serious issues with your local install, do not un-comment the following line.
  #npm audit fix --force
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Compile-Solidity-Code-With-Hardhat" ]; then
  echo
  echo "------------------------------------[[[[ Compile-Solidity-Code-With-Hardhat ]]]]------------------------------------"
  echo
  echo "This command will run the Compile-Solidity-Code-With-Hardhat script. This run started on $TIMESTAMP."
  echo
  npx hardhat clean
  npx hardhat compile > ./logs/hardhat-contract-compile.log &&
  cat ./logs/hardhat-contract-compile.log
  ls -la | grep SimpleStorage
  sleep 2
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-Deployment-On-Local-Default-Hardhat-Node" ]; then
  echo
  echo "------------------------------------[[[[ Start-Deployment-On-Local-Default-Hardhat-Node ]]]]------------------------------------"
  echo
  echo "This command will run the Start-Deployment-On-Local-Default-Hardhat-Node script. This run started on $TIMESTAMP."
  echo
  killall yarn > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall node > /dev/null 2>&1
  pkill yarnn > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  sleep 4
  source ./.env
  npx hardhat node > ./logs/hardhat-default-network-node-standalone-mode.log &
  sleep 10
  echo
  echo
  echo "-------->>>> Deployment Results Log :: $1 <<<<--------" > ./logs/hardhat-contract-default-deployment-standalone-mode.log
  npx hardhat run --network localhost ./scripts/Lesson6CodeSessions_deploy.js >> ./logs/hardhat-contract-default-deployment-standalone-mode.log &&
  cat ./logs/hardhat-contract-default-deployment-standalone-mode.log
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-Deployment-On-Local-Forked-Fantom-Mainnet" ]; then
  echo
  echo "------------------------------------[[[[ Start-Deployment-On-Local-Forked-Fantom-Mainnet ]]]]------------------------------------"
  echo
  echo "This command will run the Start-Deployment-On-Local-Forked-Fantom-Mainnet script. This run started on $TIMESTAMP."
  echo
  killall yarn > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall node > /dev/null 2>&1
  pkill yarnn > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  sleep 4
  source ./.env
  npx hardhat node --config Lesson6CodeSessions_fantom-hardhat.config.js > ./logs/hardhat-fantom-network-node-standalone-mode.log &
  sleep 10
  echo
  echo
  echo "-------->>>> Deployment Results Log :: $1 <<<<--------" > ./logs/hardhat-contract-fantom-deployment-standalone-mode.log
  npx hardhat run --network hardhat ./scripts/Lesson6CodeSessions_deploy.js >> ./logs/hardhat-contract-fantom-deployment-standalone-mode.log &&
  cat ./logs/hardhat-contract-fantom-deployment-standalone-mode.log
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-Deployment-On-Real-Ethereum-Testnet" ]; then
  echo
  echo "------------------------------------[[[[ Start-Deployment-On-Real-Ethereum-Testnet ]]]]------------------------------------"
  echo
  echo "This command will run the Start-Deployment-On-Real-Ethereum-Testnet script. This run started on $TIMESTAMP."
  echo
  killall yarn > /dev/null 2>&1
  killall npm > /dev/null 2>&1
  killall node > /dev/null 2>&1
  pkill yarnn > /dev/null 2>&1
  pkill npm > /dev/null 2>&1
  pkill node > /dev/null 2>&1
  sleep 4
  source ./.env
  echo
  echo
  echo "-------->>>> Deployment Results Log :: $1 :: Sepolia <<<<--------" > ./logs/hardhat-contract-ethereum-testnet-deployment.log
  npx hardhat run --network sepolia ./scripts/Lesson6CodeSessions_deploy.js >> ./logs/hardhat-contract-ethereum-testnet-deployment.log &&
  cat ./logs/hardhat-contract-ethereum-testnet-deployment.log
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

if [ "$1" == "Start-Datadriven-Hardhat-Test" ]; then
  echo
  echo "------------------------------------[[[[ Start-Datadriven-Hardhat-Test ]]]]------------------------------------"
  echo
  echo "This command will run the Start-Datadriven-Hardhat-Test script. This run started on $TIMESTAMP."
  echo
  source ./.env
  export expectedValue1="0"; export expectedValue2="18"; export expectedPersonName="Jenny"; export expectedFavoriteNumber="8675309"; npx hardhat test > ./logs/hardhat-datadriven-test-report.log
  sleep 2
  cat ./gas-report.txt >> ./logs/hardhat-datadriven-test-report.log
  cat ./logs/hardhat-datadriven-test-report.log
  echo
  echo
  TIMESTAMP2=$(date)
  echo "This run ended on $TIMESTAMP2."
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "This tool runner script can be used to run the following commands to deploy the Solidity examples from the Patrick Collins FCC Solidity YouTube course."
  echo
  echo "You can view just this help menu again (without triggering any automation) by running 'bash ./Lesson6CodeSessions_start-deployment-scripts.sh -h' or 'bash ./Lesson6CodeSessions_start-deployment-scripts.sh --help'."
  echo
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-Clean-Environment"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Hardhat"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Default-Hardhat-Node"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Forked-Fantom-Mainnet"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Real-Ethereum-Testnet"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Datadriven-Hardhat-Test"
  echo
  echo "If you're running this for the first time run the following before running Start-Deployment-On-Local-Hardhat-Node."
  echo
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux"
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Hardhat"
  echo
  echo "Then you can run the following combined commands in your terminal to deploy the contract to the Hardhat local blockchain node."
  echo
  echo "bash ./Lesson6CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-Clean-Environment && bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Default-Hardhat-Node"
  echo
  echo "You can also use the provided Lesson6CodeSessions_start-automation-build-pipeline.sh to run all the above commands in a sequence similar to a build pipeline."
  echo
  echo "bash ./Lesson6CodeSessions_start-automation-build-pipeline.sh"
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi

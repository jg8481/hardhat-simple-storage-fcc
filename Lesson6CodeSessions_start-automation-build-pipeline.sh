#! /bin/bash

clear
TIMESTAMP=$(date)
CURRENT_DIRECTORY=$(pwd)
cd "$CURRENT_DIRECTORY"
rm -rf ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
echo "This automation build pipeline run started on $TIMESTAMP." >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
echo "SETUP STAGE :: CLEAN THE BUILD ENVIRONMENT" >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Stop-Local-Blockchain-Nodes-Clean-Environment >> ./logs/hardhat-build-pipeline.log &&
echo >> ./logs/hardhat-build-pipeline.log
echo "BUILD STAGE 1 :: INSTALL THE REQUIRED TOOLS" >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
sleep 2
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Install-Tools-On-MacOS-Or-Linux >> ./logs/hardhat-build-pipeline.log &&
echo >> ./logs/hardhat-build-pipeline.log
echo "BUILD STAGE 2 :: COMPILE THE SOLIDITY CODE AND CHECK BUILD ARTIFACTS" >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
sleep 2
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Compile-Solidity-Code-With-Hardhat >> ./logs/hardhat-build-pipeline.log &&
echo >> ./logs/hardhat-build-pipeline.log
echo "BUILD STAGE 3 :: DEPLOY THE SMART CONTRACT(S) TO A LOCAL BLOCKCHAIN NODE" >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
sleep 2
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Local-Default-Hardhat-Node >> ./logs/hardhat-build-pipeline.log &&
echo >> ./logs/hardhat-build-pipeline.log
echo "BUILD STAGE 4 :: TEST THE DEPLOYED SMART CONTRACT(S) ON A LOCAL BLOCKCHAIN NODE" >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
sleep 2
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Datadriven-Hardhat-Test >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
if grep --quiet "failing" ./logs/hardhat-datadriven-test-report.log; then
    echo >> ./logs/hardhat-build-pipeline.log
    echo >> ./logs/hardhat-build-pipeline.log
    echo "WARNING: TEST FAILURES WERE DETECTED! THIS AUTOMATION PIPELINE WILL FAIL AND STOP DEPLOYMENT TO THE ETHEREUM TESTNET." >> ./logs/hardhat-build-pipeline.log
    echo >> ./logs/hardhat-build-pipeline.log
    echo >> ./logs/hardhat-build-pipeline.log
    cat ./logs/hardhat-datadriven-test-report.log >> ./logs/hardhat-build-pipeline.log
    cat ./logs/hardhat-build-pipeline.log
    exit 1
else
    echo >> ./logs/hardhat-build-pipeline.log
    echo >> ./logs/hardhat-build-pipeline.log
    echo "ALL TESTS PASSED. DEPLOYMENT TO THE ETHEREUM TESTNET WILL CONTINUE." >> ./logs/hardhat-build-pipeline.log
    echo >> ./logs/hardhat-build-pipeline.log
    echo >> ./logs/hardhat-build-pipeline.log
fi    
echo "BUILD STAGE 5 :: DEPLOY THE SMART CONTRACT(S) TO ETHEREUM TESTNET" >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
sleep 2
bash ./Lesson6CodeSessions_start-deployment-scripts.sh Start-Deployment-On-Real-Ethereum-Testnet >> ./logs/hardhat-build-pipeline.log &&
echo >> ./logs/hardhat-build-pipeline.log
echo "This automation build pipeline run ended on $TIMESTAMP." >> ./logs/hardhat-build-pipeline.log
echo >> ./logs/hardhat-build-pipeline.log
cat ./logs/hardhat-build-pipeline.log
exit

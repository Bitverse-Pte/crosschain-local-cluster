# Crosschain-local-cluster


This project will help to create a simple cluster on a single machine, which will include:
- teleport node
- eth private chain node
- tss cluster
- ...


## introduction

本工具可以作为在ubuntu或者macos上部署跨链集群的基础框架，包括：
- teleport 节点。
- 以太坊私有链节点
- tss节点集群
- 以及可以在该框架基础上对接其它异构链节点等等。


同时还可以作为向rinkeby，ethereum-mainet，bnb-chain自动化部署合约的工具。以eth为例，需要做的工作如下：
- 修改eth-tele目录下env_var/variable.sh 中所要部署的链的环境变量。
- 修改eth-tele目录下hardhat-config中的ts文件，重点修改network name，chain id，chain url，账户的私钥。
- source 2_download_helper.sh 下载部署基础项目。主要为xibc-contracts。
- source 3_deploy_base_contract.sh。在指定目标链上自动部署基础智能合约。通过脚本控制，添加了部署失败重试，以及超过5次自动退出的功能。

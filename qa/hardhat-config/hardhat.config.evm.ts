import "@nomiclabs/hardhat-waffle"
import "@openzeppelin/hardhat-upgrades"
import "@openzeppelin/hardhat-defender"
import "@nomiclabs/hardhat-ethers"
import "@typechain/hardhat"
import "hardhat-gas-reporter"
import "hardhat-contract-sizer"
import "hardhat-abi-exporter"
import "./tasks/deployLibraries"
import "./tasks/deployTssClient"
import "./tasks/deployTendermintClient"
import "./tasks/deployClientManager"
import "./tasks/deployPacket"
import "./tasks/deployRouting"
import "./tasks/deployTransfer"
import "./tasks/deployMultiCall"
import "./tasks/deployRcc"
import "./tasks/deployProxy"
import "./tasks/deployAccessManager"
import "./tasks/transfer"

// @ts-ignore
module.exports = {
    defaultNetwork: 'hardhat',
    defender: {
        apiKey: "[apiKey]",
        apiSecret: "[apiSecret]",
    },
    networks: {
        hardhat: {
            allowUnlimitedContractSize: true,
        },
        teleport: {
            url: 'http://localhost:8545',
            gasPrice: 5000000000,
            chainId: 7001,
            gas: 4100000,
            accounts: ['380896e1b43b6c40e3b8c7ff72f827efd141049439e031d3c81ebd573e9f5a01'],
        },
        ethmock: {
            url: 'http://localhost:9545',
            gasPrice: 1500000000,
            chainId: 3133789,
            gas: 4100000,
            accounts: ['380896e1b43b6c40e3b8c7ff72f827efd141049439e031d3c81ebd573e9f5a01'],
        },
        rinkeby: {
            url: 'https://rinkeby.infura.io/v3/023f2af0f670457d9c4ea9cb524f0810',
            gasPrice: 1500000000,
            chainId: 4,
            gas: 4100000,
            accounts: ['380896e1b43b6c40e3b8c7ff72f827efd141049439e031d3c81ebd573e9f5a01'],
        },
        bsctest: {
            url: 'https://data-seed-prebsc-2-s2.binance.org:8545',
            gasPrice: 10000000000,
            chainId: 97,
            gas: 4100000,
            accounts: ['380896e1b43b6c40e3b8c7ff72f827efd141049439e031d3c81ebd573e9f5a01'],
        },
        ropsten: {
            url: 'https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
            gasPrice: 9000000000,
            chainId: 3,
            gas: 4100000,
            accounts: ['380896e1b43b6c40e3b8c7ff72f827efd141049439e031d3c81ebd573e9f5a01'],
        },
    },
    solidity: {
        version: '0.6.8',
        settings: {
            optimizer: {
                enabled: true,
                runs: 1000,
            },
        }
    },
    gasReporter: {
        enabled: true,
        showMethodSig: true,
        maxMethodDiff: 10,
    },
    contractSizer: {
        alphaSort: true,
        runOnCompile: true,
        disambiguatePaths: false,
    },
    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./cache",
        artifacts: "./artifacts"
    },
    abiExporter: {
        path: './abi',
        clear: true,
        spacing: 4,
    }
}
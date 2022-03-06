import "@nomiclabs/hardhat-waffle"
import "@openzeppelin/hardhat-upgrades"
import "@typechain/hardhat"
import "hardhat-gas-reporter"
import "hardhat-contract-sizer"
import "hardhat-abi-exporter"
import "./tasks/token"

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
            accounts: ['6395A7C842A08515961888D21D72F409B61FBCE96AF1E520384E375F301A8297'],
        },
        ethmock: {
            url: 'http://localhost:9545',
            gasPrice: 1500000000,
            chainId: 3133789,
            gas: 4100000,
            accounts: ['6395A7C842A08515961888D21D72F409B61FBCE96AF1E520384E375F301A8297'],
        },
        rinkeby: {
            url: 'https://rinkeby.infura.io/v3/023f2af0f670457d9c4ea9cb524f0810',
            gasPrice: 1500000000,
            chainId: 4,
            gas: 4100000,
            accounts: ['6395A7C842A08515961888D21D72F409B61FBCE96AF1E520384E375F301A8297'],
        },
        bsctest: {
            url: 'https://data-seed-prebsc-2-s2.binance.org:8545',
            gasPrice: 10000000000,
            chainId: 97,
            gas: 4100000,
            accounts: ['6395A7C842A08515961888D21D72F409B61FBCE96AF1E520384E375F301A8297'],
        },
    },
    solidity: {
        version: '0.8.0',
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
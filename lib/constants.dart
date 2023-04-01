import 'package:ens_dart/ens_dart.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class Constants {
  static http.Client httpClient = http.Client();
  static String rpc_url_mainnet = "https://eth.llamarpc.com";
  static String rpc_url_goerli =
      "https://goerli.infura.io/v3/a1a50b6285a944d98e643e6efe0bc6bf";
  static Web3Client web3ClientMainnet = Web3Client(rpc_url_mainnet, httpClient);
  static Web3Client web3ClientGoerli = Web3Client(rpc_url_goerli, httpClient);
  static Credentials userCredentials = EthPrivateKey.fromHex('');
  static EthereumAddress ethereumAddress = userCredentials.address;
  static String address = userCredentials.address.hex;
  static final ensClient = Ens(client: web3ClientMainnet);
  static List<DropdownMenuItem<String>> gasRates = [
    DropdownMenuItem(child: Text("Low"), value: "Low"),
    DropdownMenuItem(child: Text("Market"), value: "Market"),
    DropdownMenuItem(child: Text("Aggressive"), value: "Aggressive")
  ];
  static Map<String, String> gasRatesList = {
    "Low": "0",
    "Market": "1",
    "Aggressive": "2"
  };
  static List<DropdownMenuItem<String>> tokens = [
    DropdownMenuItem(child: Text("ETH"), value: "ETH"),
    DropdownMenuItem(child: Text("DAI"), value: "DAI"),
    DropdownMenuItem(child: Text("UNI"), value: "UNI"),
    DropdownMenuItem(child: Text("UDSC"), value: "USDC"),
    DropdownMenuItem(child: Text("USDT"), value: "USDT"),
    DropdownMenuItem(child: Text("LINK"), value: "LINK"),
    DropdownMenuItem(child: Text("SAND"), value: "SAND"),
    // DropdownMenuItem(child: Text("MATIC"), value: "MATIC"),
    // DropdownMenuItem(child: Text("USD Mapped Token"), value: "USDM"),
    // DropdownMenuItem(child: Text("WETH"), value: "WETH"),
    // DropdownMenuItem(child: Text("BUSD"), value: "BUSD"),
  ];
  static Map<String, String> tokenAddressList = {
    "ETH": "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
    "DAI": "0xBa8DCeD3512925e52FE67b1b5329187589072A55",
    "UNI": "0x1f9840a85d5af5bf1d1762f925bdaddc4201f984",
    "USDC": "0x07865c6e87b9f70255377e024ace6630c1eaa37f",
    "USDT": "0x56705db9f87c8a930ec87da0d458e00a657fccb0 ",
    "LINK": "0xe9c4393a23246293a8D31BF7ab68c17d4CF90A29",
    "SAND": "0xbbba073c31bf03b8acf7c28ef0738decf3695683"
  };
  static final contractAbi = [
    {
      "constant": true,
      "inputs": [],
      "name": "name",
      "outputs": [
        {"name": "", "type": "string"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {"name": "_spender", "type": "address"},
        {"name": "_value", "type": "uint256"}
      ],
      "name": "approve",
      "outputs": [
        {"name": "", "type": "bool"}
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "totalSupply",
      "outputs": [
        {"name": "", "type": "uint256"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {"name": "_from", "type": "address"},
        {"name": "_to", "type": "address"},
        {"name": "_value", "type": "uint256"}
      ],
      "name": "transferFrom",
      "outputs": [
        {"name": "", "type": "bool"}
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "decimals",
      "outputs": [
        {"name": "", "type": "uint8"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {"name": "_owner", "type": "address"}
      ],
      "name": "balanceOf",
      "outputs": [
        {"name": "balance", "type": "uint256"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "symbol",
      "outputs": [
        {"name": "", "type": "string"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {"name": "_to", "type": "address"},
        {"name": "_value", "type": "uint256"}
      ],
      "name": "transfer",
      "outputs": [
        {"name": "", "type": "bool"}
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {"name": "_owner", "type": "address"},
        {"name": "_spender", "type": "address"}
      ],
      "name": "allowance",
      "outputs": [
        {"name": "", "type": "uint256"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {"payable": true, "stateMutability": "payable", "type": "fallback"},
    {
      "anonymous": false,
      "inputs": [
        {"indexed": true, "name": "owner", "type": "address"},
        {"indexed": true, "name": "spender", "type": "address"},
        {"indexed": false, "name": "value", "type": "uint256"}
      ],
      "name": "Approval",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {"indexed": true, "name": "from", "type": "address"},
        {"indexed": true, "name": "to", "type": "address"},
        {"indexed": false, "name": "value", "type": "uint256"}
      ],
      "name": "Transfer",
      "type": "event"
    }
  ];
}

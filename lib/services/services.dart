import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'dart:math' as math;
import '../constants.dart';

class Services {
  transaction({required Transaction transactiondata}) async {
    try {
      var chainID = await Constants.web3ClientGoerli.getChainId();
      log(Constants.ethereumAddress.hex);

      log(chainID.toString());
      String transactionHash = await Constants.web3ClientGoerli.sendTransaction(
          chainId: chainID.toInt(), Constants.userCredentials, transactiondata);
      Fluttertoast.showToast(msg: "Transaction Succesfull");
      log(transactionHash);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString().substring(
              e.toString().indexOf('"') + 1, e.toString().lastIndexOf('"')));
    }
  }

  initNotifications() {
    AwesomeNotifications().initialize(
        '',
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            // defaultColor: Color(0xFF9D50DD),
            // ledColor: Colors.white)
          )
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    checkNotificationPermission() {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }
  }

  transferToken(
      {String token = '',
      String to = '',
      String amount = '',
      String gasPriority = '1'}) async {
    var tokenContract =
        await loadErc20Contract(token, Constants.web3ClientGoerli);
    var transferFunc = tokenContract.function('transfer');
    var chainId = await Constants.web3ClientGoerli.getChainId();
    var gasOptions = await Constants.web3ClientGoerli.getGasInEIP1559();
    var value = EtherAmount.fromBase10String(EtherUnit.ether, amount);
    try {
      // contract.function(name).encodeCall(params)
      //low,market,aggressive
      var trans = await Constants.web3ClientGoerli.sendTransaction(
          chainId: chainId.toInt(),
          Constants.userCredentials,
          Transaction.callContract(
              maxFeePerGas: EtherAmount.fromBigInt(EtherUnit.wei,
                  gasOptions[int.parse(gasPriority)].maxFeePerGas),
              contract: tokenContract,
              maxPriorityFeePerGas: EtherAmount.fromBigInt(EtherUnit.wei,
                  gasOptions[int.parse(gasPriority)].maxPriorityFeePerGas),
              function: transferFunc,
              parameters: [EthereumAddress.fromHex(to), value.getInWei]));
    } catch (e) {
      log(e.toString());
    }
    // var gasOptions = await evm.getGasFee(client);
    // var transferTx = evm.createContractTransaction(
    //     tokenContract,
    //     transferFunc,
    //     [EthereumAddress.fromHex(to), BigInt.parse(amount)],
    //     gasOptions[1].maxFeePerGas,
    //     gasOptions[1].maxPriorityFeePerGas);
    // return await evm.sendTransaction(client, network, credentials, transferTx);
  }

  loadErc20Contract(
    String tokenAddress,
    Web3Client client,
  ) {
    return loadContract("erc20.abi.json", tokenAddress, client);
  }

  Future<DeployedContract> loadContract(
      String abiPath, String contractAddress, Web3Client client) async {
    return DeployedContract(
        ContractAbi.fromJson(jsonEncode(Constants.contractAbi), "ERC20"),
        EthereumAddress.fromHex(contractAddress));
  }

  fetchENS(var add) async {
    var ens;
    try {
      add = await Constants.ensClient.withName(add).getAddress();
      if (add.hex.toString().contains("Service Unavailable") ||
          add.hex
              .toString()
              .contains("0x0000000000000000000000000000000000000000") ||
          add.hex.toString().contains("Connection")) {
        Fluttertoast.showToast(msg: "Couldnt find ENS, Please try again");
      } else {
        Fluttertoast.showToast(msg: "Found a valid ENS");
        ens = add.toString();
      }
      // log(add.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return ens;
  }
}

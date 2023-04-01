import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/services.dart';
import 'package:web3dart/web3dart.dart';
import '../constants.dart';
import 'dart:math' as math;

class ERC20FlowScreen extends StatefulWidget {
  const ERC20FlowScreen({super.key});

  @override
  State<ERC20FlowScreen> createState() => _ERC20FlowScreenState();
}

class _ERC20FlowScreenState extends State<ERC20FlowScreen> {
  final addressController1 = TextEditingController();
  final _valueController1 = TextEditingController();
  final addressController2 = TextEditingController();
  final _valueController2 = TextEditingController();

  static String addr = '';
  String selectedPriority = 'Market';
  String selectedToken = "ETH";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                // key: addressKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                      onChanged: (value) async {
                        var trimmed = value.trim();
                        if (trimmed.isNotEmpty && !trimmed.contains(" ")) {
                          if (addressController1.text.endsWith(".eth")) {
                            try {
                              var ens = await Services()
                                  .fetchENS(addressController1.text);
                              addr = ens;
                            } catch (e) {}
                          } else if (addressController1.text.startsWith("0x") &&
                              addressController1.text.length == 42) {
                            addr = addressController1.text;
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid ENS or Address");
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter a valid ENS or Address");
                        }
                      },
                      // cursorColor: Color(0xFF064848),
                      controller: addressController1,
                      decoration: InputDecoration(
                          label: Text(
                        "Address or ENS",
                      )),
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                ),
              ),
              Form(
                // key: valueKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                      // onChanged: ,
                      keyboardType: TextInputType.number,
                      controller: _valueController1,
                      decoration: const InputDecoration(
                          label: Text(
                        "Value",
                      )),
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      var maxGas =
                          await Constants.web3ClientGoerli.estimateGas();
                      var gasPrice =
                          await Constants.web3ClientGoerli.getGasPrice();
                      var bal = await Constants.web3ClientGoerli
                          .getBalance(Constants.ethereumAddress);
                      log(bal.toString());
                      if (addressController1.text.isNotEmpty &&
                          _valueController1.text.isNotEmpty) {
                        double sendValue = double.parse(_valueController1.text);
                        sendValue = sendValue * math.pow(10, 18);
                        Services().transaction(
                            transactiondata: Transaction(
                                from: Constants.ethereumAddress,
                                to: EthereumAddress.fromHex(addr),
                                value: EtherAmount.fromBigInt(
                                    EtherUnit.wei,
                                    BigInt.from(double.parse(
                                        sendValue.toInt().toString()))),
                                maxGas: maxGas.toInt(),
                                gasPrice: gasPrice));
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Please enter a valid ENS or Address or Value");
                      }
                    },
                    child: Text("Send Native")),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              Form(
                // key: addressKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                      onChanged: (value) async {
                        var trimmed = value.trim();
                        if (trimmed.isNotEmpty && !trimmed.contains(" ")) {
                          if (addressController2.text.endsWith(".eth")) {
                            try {
                              var ens = await Services()
                                  .fetchENS(addressController2.text);
                              addr = ens;
                            } catch (e) {}
                          } else if (addressController2.text.startsWith("0x") &&
                              addressController2.text.length == 42) {
                            addr = addressController2.text;
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid ENS or Address");
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please enter a valid ENS or Address");
                        }
                      },
                      // cursorColor: Color(0xFF064848),
                      controller: addressController2,
                      decoration: InputDecoration(
                          label: Text(
                        "Address or ENS",
                      )),
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                ),
              ),
              Form(
                // key: valueKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                      // onChanged: ,
                      keyboardType: TextInputType.number,
                      controller: _valueController2,
                      decoration: const InputDecoration(
                          label: Text(
                        "Value",
                      )),
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: selectedToken,
                          items: Constants.tokens,
                          onChanged: (String? value) {
                            setState(() {
                              selectedToken = value.toString();
                            });
                            log(value.toString());
                          })),
                  DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: selectedPriority,
                          items: Constants.gasRates,
                          onChanged: (String? value) {
                            setState(() {
                              selectedPriority = value.toString();
                            });
                            log(value.toString());
                          })),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      double sendValue = double.parse(_valueController2.text);
                      // sendValue = sendValue * math.pow(10, 18);

                      try {
                        Services().transferToken(
                            token: Constants.tokenAddressList[selectedToken]
                                .toString(),
                            to: addr,
                            amount: sendValue.toInt().toString(),
                            gasPriority: Constants
                                .gasRatesList[selectedPriority]
                                .toString());
                      } catch (e) {
                        log(e.toString());
                        Fluttertoast.showToast(
                            msg:
                                "Please enter a valid ENS or Address or Value");
                      }
                      // TODO
                    },
                    child: Text("Send ERC20")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

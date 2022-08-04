import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import '../../core/constants.dart';

class ETHProvider extends ChangeNotifier {
  bool signInSuccess = false;
  bool isLoadingBalance = true;

  late Web3Client web3Client;
  late Client httpClient;
  BigInt currentChainID = BigInt.from(1);

  Credentials? credentials;
  EthereumAddress? addressfromHex;
  String addressfromString = '';
  double currentBalance = 0;

  String receiverAddress = '';
  double receiverBalance = 0;
  double amount = 0;

  void autoRefresh() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getBalance();
      debugPrint('Refreshing balance.');
    });
  }

  ETHProvider() {
    initProvider();
  }

  Future<void> initProvider() async {
    httpClient = Client();
    web3Client =
        Web3Client(EnvironmentVariables.urlETHClientDefault, httpClient);
    currentChainID =
        BigInt.from(EnvironmentVariables.listChainIDMap['Mainnet']!);
    notifyListeners();
  }

  Future<void> changeNetwork(String network) async {
    httpClient = Client();
    web3Client =
        Web3Client(EnvironmentVariables.urlETHClientMap[network]!, httpClient);
    currentChainID = BigInt.from(EnvironmentVariables.listChainIDMap[network]!);
    await getBalance();
    notifyListeners();
  }

  Future<String> getCredentials(String privateKey) async {
    credentials = EthPrivateKey.fromHex(privateKey);
    addressfromHex = await credentials!.extractAddress();
    addressfromString = addressfromHex.toString();
    currentChainID = await web3Client.getChainId();
    debugPrint(addressfromString);
    notifyListeners();
    return addressfromString;
  }

  void changeLoadingStatus(bool status) {
    isLoadingBalance = status;
  }

  Future<void> getBalance() async {
    changeLoadingStatus(true);
    EtherAmount balance = await web3Client.getBalance(addressfromHex!);
    currentBalance = balance.getValueInUnit(EtherUnit.ether);
    debugPrint(currentBalance.toString());
    changeLoadingStatus(false);
    notifyListeners();
  }

  Future<void> getReceiverBalance(String address) async {
    EthereumAddress addressfromHex = EthereumAddress.fromHex(address);
    EtherAmount balance = await web3Client.getBalance(addressfromHex);
    receiverBalance = balance.getValueInUnit(EtherUnit.ether);
    debugPrint(receiverBalance.toString());
    notifyListeners();
  }

  // ! Increase gasFee for better perform transaction.
  Future<String> sendETH(String toAddress, double value) async {
    var gasFee = await web3Client.getGasPrice();
    var result = await web3Client.sendTransaction(
      credentials!,
      Transaction(
        maxGas: 21000,
        gasPrice: EtherAmount.inWei(gasFee.getInWei * BigInt.from(2) - BigInt.one),
        to: EthereumAddress.fromHex(toAddress),
        value: EtherAmount.fromUnitAndValue(
            EtherUnit.wei, BigInt.from(value * pow(10, 18))),
      ),
      // * chain ID of Rinkeby Testnet
      chainId: currentChainID.toInt(),
    );
    return result;
  }

  Future<String> sendAllETH(String toAddress, double value) async {
    var gasFee = await web3Client.getGasPrice();
    var totalFee = BigInt.from(21000) * gasFee.getInWei * BigInt.from(2);
    var finalValue = BigInt.from(value * pow(10, 18)) - totalFee;

    debugPrint('Gas fee per unit: $gasFee');
    debugPrint('Total fee(x2 than base fee): $totalFee');
    debugPrint('Final value: $finalValue');

    var result = await web3Client.sendTransaction(
      credentials!,
      Transaction(
        maxGas: 21000,
        gasPrice:
            EtherAmount.inWei(gasFee.getInWei * BigInt.from(2) - BigInt.one),
        from: addressfromHex!,
        to: EthereumAddress.fromHex(toAddress),
        value: EtherAmount.fromUnitAndValue(EtherUnit.wei, finalValue),
      ),
      // * chain ID of Rinkeby Testnet
      chainId: currentChainID.toInt(),
    );
    return result;
  }

  void reset() {
    signInSuccess = false;
    isLoadingBalance = true;
    credentials = null;
    addressfromHex = null;
    addressfromString = '';
    currentBalance = 0;
    receiverAddress = '';
    receiverBalance = 0;
    amount = 0;
    initProvider();
    notifyListeners();
  }

  void resetReceiver() {
    receiverAddress = '';
    receiverBalance = 0;
    amount = 0;
    notifyListeners();
  }
}

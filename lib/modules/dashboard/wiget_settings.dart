import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wakucoin/core/constants.dart';
import 'package:wakucoin/data/provider/eth_provider.dart';

Widget settings(BuildContext context) {
  return Container(
    width: context.screenWidth * 90 / 100,
    height: context.screenWidth * 80 / 100,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 10))
        ]),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Change Network',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, value, child) {
              return DropdownButton(
                  menuMaxHeight: context.screenHeight * 20 / 100,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2,
                  value: EnvironmentVariables.listChainIDMap.keys.firstWhere(
                      (element) =>
                          EnvironmentVariables.listChainIDMap[element] ==
                          int.parse(
                              Provider.of<ETHProvider>(context, listen: true)
                                  .currentChainID
                                  .toString()),
                      orElse: (() => 'Null')),
                  items: EnvironmentVariables.listNetwork
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newNetwork) {
                    Provider.of<ETHProvider>(context, listen: false)
                        .changeNetwork(newNetwork.toString());
                    Provider.of<ETHProvider>(context, listen: false)
                        .getTransactionHistory(
                            Provider.of<ETHProvider>(context, listen: false)
                                .addressfromString,
                            EnvironmentVariables.listChainIDMap.keys.firstWhere(
                                (element) =>
                                    EnvironmentVariables
                                        .listChainIDMap[element] ==
                                    int.parse(Provider.of<ETHProvider>(context,
                                            listen: false)
                                        .currentChainID
                                        .toString())));
                  });
            },
          ),
          const SizedBox(height: 20),
          const Text('Check balance',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 10),
          TextField(
            onSubmitted: (value) {
              if (true) {
                Provider.of<ETHProvider>(context, listen: false)
                    .getReceiverBalance(value);
              }
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Receiver Wallet Address'),
          ),
          const SizedBox(height: 20),
          Consumer<ETHProvider>(
            builder: (context, value, child) {
              return Text(
                  'Balance: ${Provider.of<ETHProvider>(context, listen: true).receiverBalance}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green));
            },
          ),
        ],
      ),
    ),
  );
}

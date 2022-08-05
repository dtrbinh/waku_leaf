import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wakucoin/data/provider/eth_provider.dart';

Widget sendETH(BuildContext context) {
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
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Transaction Information',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Receiver Wallet Address'),
            // ! TODO: Check valid address input
            onChanged: (value) {
              if (true) {
                Provider.of<ETHProvider>(context, listen: false)
                    .receiverAddress = value;
              }
            },
            onSubmitted: (value) {
              if (true) {
                Provider.of<ETHProvider>(context, listen: false)
                    .receiverAddress = value;
              }
            },
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Amount of transfer'),
            onChanged: (value) {
              // ! TODO: check if value <= balance
              if (true) {
                Provider.of<ETHProvider>(context, listen: false).amount =
                    double.parse(value);
              }
            },
            onSubmitted: (value) {
              // ! TODO: check if value <= balance
              if (value != '') {
                Provider.of<ETHProvider>(context, listen: false).amount =
                    double.parse(value);
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Provider.of<ETHProvider>(context, listen: false)
                        .estimateTotalFee(
                            Provider.of<ETHProvider>(context, listen: false)
                                .amount);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirm'),
                            content: SizedBox(
                              width: context.screenWidth * 70 / 100,
                              height: context.screenWidth * 40 / 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'Are you sure to send this transaction?'),
                                  Text(
                                    'Receiver: ${Provider.of<ETHProvider>(context, listen: true).receiverAddress}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Amount: ${Provider.of<ETHProvider>(context, listen: true).amount}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Consumer<ETHProvider>(
                                    builder: (context, value, child) {
                                      return Text(
                                        'Transaction fee: ${Provider.of<ETHProvider>(context, listen: true).totalFee / BigInt.from(pow(10, 18))}.',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  debugPrint(Provider.of<ETHProvider>(context,
                                          listen: false)
                                      .sendETH(
                                          Provider.of<ETHProvider>(context,
                                                  listen: false)
                                              .receiverAddress,
                                          Provider.of<ETHProvider>(context,
                                                  listen: false)
                                              .amount)
                                      .toString());
                                  FocusScope.of(context).unfocus();
                                  Provider.of<ETHProvider>(context,
                                          listen: false)
                                      .resetReceiver();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('Send')),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          Provider.of<ETHProvider>(context, listen: false)
                              .estimateTotalFee(Provider.of<ETHProvider>(
                                      context,
                                      listen: false)
                                  .currentBalance);
                          return AlertDialog(
                            title: const Text(
                              'Confirm',
                            ),
                            content: SizedBox(
                              width: context.screenWidth * 70 / 100,
                              height: context.screenWidth * 50 / 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'Are you sure to send this transaction?'),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Receiver: ${Provider.of<ETHProvider>(context, listen: false).receiverAddress}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Amount: ${Provider.of<ETHProvider>(context, listen: false).currentBalance}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Consumer(
                                    builder: (context, value, child) {
                                      return Text(
                                        'Transaction fee: ${Provider.of<ETHProvider>(context, listen: true).totalFee / BigInt.from(pow(10, 18))}.',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      );
                                    },
                                  ),
                                  Consumer(
                                    builder: (context, value, child) {
                                      return Text(
                                        'Final amoumt: ${Provider.of<ETHProvider>(context, listen: true).finalValue / BigInt.from(pow(10, 18))}.',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  debugPrint(Provider.of<ETHProvider>(context,
                                          listen: false)
                                      .sendAllETH(
                                          Provider.of<ETHProvider>(context,
                                                  listen: false)
                                              .receiverAddress,
                                          Provider.of<ETHProvider>(context,
                                                  listen: false)
                                              .currentBalance)
                                      .toString());
                                  FocusScope.of(context).unfocus();
                                  Provider.of<ETHProvider>(context,
                                          listen: false)
                                      .resetReceiver();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('Send All')),
            ],
          ).centered(),
        ]),
  );
}

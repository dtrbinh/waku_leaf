import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wakucoin/data/models/transaction_history.dart';
import 'package:wakucoin/data/provider/eth_provider.dart';

Widget historyCard(Result transaction, BuildContext context) {
  return SizedBox(
    width: context.screenWidth * 0.8,
    height: context.screenHeight * 0.18,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.green),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            transaction.to == context.read<ETHProvider>().addressfromString
                ? const Text(
                    'IN',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  )
                : const Text(
                    'OUT',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
            Text(
              'Time: ${DateTime.fromMillisecondsSinceEpoch(int.parse(transaction.timeStamp) * 1000)}',
              style: const TextStyle(fontSize: 13, color: Colors.green),
            ),
            Text(
              'From: ${transaction.from}',
              style: const TextStyle(fontSize: 13, color: Colors.green),
            ),
            Text(
              'To: ${transaction.to}',
              style: const TextStyle(fontSize: 13, color: Colors.green),
            ),
            Text(
              'Value: ${BigInt.parse(transaction.value) / BigInt.from(pow(10, 18))} ETH',
              style: const TextStyle(fontSize: 13, color: Colors.green),
            ),
            Text(
              'Status: ${transaction.txreceiptStatus == '1' ? 'Success' : 'Failed'}',
              style: const TextStyle(fontSize: 13, color: Colors.green),
            ),
          ],
        ),
      ),
    ),
  );
}

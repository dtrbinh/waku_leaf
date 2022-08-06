import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakucoin/core/constants.dart';
import 'package:wakucoin/modules/history/widget_historycard.dart';

import '../../data/provider/eth_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ETHProvider>().getTransactionHistory(
                    context.read<ETHProvider>().addressfromString,
                    EnvironmentVariables.listChainIDMap.keys.firstWhere(
                        (element) =>
                            EnvironmentVariables.listChainIDMap[element] ==
                            int.parse(context
                                .read<ETHProvider>()
                                .currentChainID
                                .toString())));
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Consumer<ETHProvider>(
        builder: (context, value, child) {
          return ListView(
              children: context
                  .watch<ETHProvider>()
                  .transactionHistory!
                  .result
                  .map<Widget>((e) => historyCard(e, context))
                  .toList());
        },
      ),
    );
  }
}

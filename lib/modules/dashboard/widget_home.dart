import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wakucoin/core/constants.dart';
import 'package:wakucoin/data/provider/dashboard_provider.dart';
import 'package:wakucoin/data/provider/eth_provider.dart';
import 'package:wakucoin/modules/sign_in/sign_in_screen.dart';

Widget home(BuildContext context) {
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
          Text(
              'Current network: ${EnvironmentVariables.listChainIDMap.keys.firstWhere((element) => EnvironmentVariables.listChainIDMap[element] == int.parse(Provider.of<ETHProvider>(context, listen: false).currentChainID.toString()), orElse: (() => 'Network not found'))}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 20),
          Text(
              'Chain ID: ${Provider.of<ETHProvider>(context, listen: false).currentChainID.toString()}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          const SizedBox(height: 20),
          ElevatedButton(
                  onPressed: () {
                    Provider.of<ETHProvider>(context, listen: false).reset();
                    Provider.of<DashBoardProvider>(context, listen: false)
                        .reset();
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) {
                        return const SignInScreen();
                      },
                    ));
                  },
                  child: const Text('Sign Out'))
              .centered()
        ],
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wakucoin/data/provider/dashboard_provider.dart';
import 'package:wakucoin/data/provider/eth_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Provider.of<ETHProvider>(context, listen: false).getBalance();
    //Provider.of<MetaMaskProvider>(context, listen: false).autoRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.green,
                width: context.screenWidth,
                height: context.screenHeight * 30 / 100,
              ),
              Row(
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: context.screenHeight * 5 / 100),
                      const Text(
                        'Waku Leaf',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      SizedBox(height: context.screenHeight * 5 / 100),
                      Container(
                        width: context.screenWidth * 90 / 100,
                        height: context.screenHeight * 20 / 100,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            const Text('Your Balance',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            const SizedBox(height: 20),
                            Consumer<ETHProvider>(
                              builder: (context, value, child) {
                                return Provider.of<ETHProvider>(context,
                                            listen: true)
                                        .isLoadingBalance
                                    ? const CircularProgressIndicator()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Provider.of<ETHProvider>(context,
                                                    listen: false)
                                                .currentBalance
                                                .toStringAsFixed(8),
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ).shimmer(),
                                          IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(
                                              Icons.refresh,
                                              color: Colors.green,
                                              size: 40,
                                            ),
                                            onPressed: () {
                                              Provider.of<ETHProvider>(context,
                                                      listen: false)
                                                  .changeLoadingStatus(true);
                                              Provider.of<ETHProvider>(context,
                                                      listen: false)
                                                  .getBalance();
                                            },
                                          )
                                        ],
                                      );
                              },
                            )
                          ],
                        )),
                      ),
                      SizedBox(height: context.screenHeight * 5 / 100),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<DashBoardProvider>(context,
                                      listen: false)
                                  .setCurrentSelection(0);
                            },
                            child: const Text('Home'),
                          ),
                          const SizedBox(width: 40),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<DashBoardProvider>(context,
                                      listen: false)
                                  .setCurrentSelection(1);
                            },
                            child: const Text('Send ETH'),
                          ),
                          const SizedBox(width: 40),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<DashBoardProvider>(context,
                                      listen: false)
                                  .setCurrentSelection(2);
                            },
                            child: const Text('Settings'),
                          )
                        ],
                      ),
                      SizedBox(height: context.screenHeight * 5 / 100),
                      Consumer<DashBoardProvider>(
                        builder: (context, value, child) {
                          return Container(
                            child: Provider.of<DashBoardProvider>(context,
                                    listen: true)
                                .getBody(context),
                          );
                        },
                      )
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wakucoin/modules/dashboard/dashboard_screen.dart';
import '../../data/provider/eth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String privatekey = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/WakuLeaf.png',
                width: 100,
              ),
              const Text('Waku Leaf',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green))
            ],
          ),
          SizedBox(height: context.screenHeight * 20 / 100),
          SizedBox(
            width: context.screenWidth * 90 / 100,
            height: context.screenHeight * 10 / 100,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.key,
                  color: Colors.green,
                ),
                labelText: 'Your Meta Mask private key',
                labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  privatekey = value;
                });
              },
              onSubmitted: (value) {
                if (value.length == 64) {
                  debugPrint(Provider.of<ETHProvider>(context, listen: false)
                      .getCredentials(value)
                      .toString());
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const DashboardScreen()));
                } else {}
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                if (privatekey.length == 64) {
                  debugPrint(Provider.of<ETHProvider>(context, listen: false)
                      .getCredentials(privatekey)
                      .toString());
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const DashboardScreen()));
                } else {}
                FocusScope.of(context).unfocus();
              },
              child: const Text('Sign In')),
          const Spacer(),
          const Text('dtrbinh', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

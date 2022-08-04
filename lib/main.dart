import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakucoin/data/provider/dashboard_provider.dart';
import 'package:wakucoin/data/provider/eth_provider.dart';
import 'package:wakucoin/modules/sign_in/sign_in_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ETHProvider()),
      ChangeNotifierProvider(create: (_) => DashBoardProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SignInScreen(),
    );
  }
}

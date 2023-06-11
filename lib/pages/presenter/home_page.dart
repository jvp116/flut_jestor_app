import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SizedBox(
        child: Column(
          children: [
            Text("HOMEPAGE"),
            Text("HOMEPAGE"),
            Text("HOMEPAGE"),
          ],
        ),
      ),
    ));
  }
}

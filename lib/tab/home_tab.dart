import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("This is home page",style: TextStyle(color: Colors.black),),
            Text("If you are alumni  ",style: TextStyle(color: Colors.black),),
          ], 

          ),
      ),
    );
  }
}
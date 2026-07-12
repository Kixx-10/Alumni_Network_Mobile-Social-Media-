import 'package:flutter/material.dart';

class FriendTab extends StatefulWidget {
  const FriendTab({super.key});

  @override
  State<FriendTab> createState() => _FriendTabState();
}

class _FriendTabState extends State<FriendTab> {
final int _currentCount=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:[
              Row(
                children: [
                  Text("Friends",style:TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                  const SizedBox(width: 10),
                  Text("$_currentCount",style:TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.red),),
                ],
              ),
            ]
          ),
        )
        )
    );
  }
}
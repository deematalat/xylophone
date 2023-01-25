


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xylophone/bulid_key.dart';

class Xylophone extends StatelessWidget {
  const Xylophone({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
              children: [
                BuildKey(Colors.red,1),
                BuildKey(Colors.pink,2),
                BuildKey(Colors.purple,3),
                BuildKey(Colors.blue,4),
                BuildKey(Colors.green,5),
                BuildKey(Colors.yellow,6),

              ],
        ),
      ),
    );
  }

}

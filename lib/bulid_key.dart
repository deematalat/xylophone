

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BuildKey extends StatelessWidget {

   BuildKey(this.color, this.num,{Key key}) : super(key: key);
    Color color;
     int num;

  @override
  Widget build(BuildContext context) {
    return   Expanded(child:
        Material(
          color:color ,
          child:
     InkWell(
      onTap: (){

      },
      child:
      Container(
      ),
    ),),
    );
  }
}

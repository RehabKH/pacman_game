import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;
  MyPath(this.innerColor, this.outerColor, this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: EdgeInsets.all(8),
            color: outerColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                // padding: EdgeInsets.all(4),
                color: innerColor,
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ));
  }
}

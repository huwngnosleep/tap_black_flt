import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  final onTap;
  final int duration;
  final Widget child;
  final double activeOpacity;

  TouchableOpacity({
    this.onTap,
    this.duration = 200,
    this.activeOpacity = 0.2,
    @required this.child,
  });

  @override
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _opacity = widget.activeOpacity;
        });
        widget.onTap();
      },
      child: AnimatedOpacity(
        onEnd: () {
          setState(() {
            _opacity = 1.0;
          });
        },
        duration: Duration(milliseconds: widget.duration),
        opacity: _opacity,
        child: widget.child,
      ),
    );
  }
}

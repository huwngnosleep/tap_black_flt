import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final onPress;
  final Icon icon;

  CustomButton({
    @required this.onPress,
    @required this.icon,
  });


  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _opacity = 1;
  void _changeOpacity() {
    setState(() => _opacity = _opacity == 1 ? 0.4 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      onEnd: () {
        setState(() {
          _opacity = 1;
        });
      },
      opacity: _opacity,
      curve: Curves.linear,
      duration: Duration(milliseconds: 100),
      child: Card(
        elevation: 5,
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(color: Theme.of(context).buttonColor),
          child: IconButton(
            icon: widget.icon,
            onPressed: () {
              _changeOpacity();
              widget.onPress();
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tap_the_black/widgets/ui/touchable_opacity.dart';

class Block extends StatefulWidget {
  final onTap;
  final bool value;

  Block({Key key, @required this.onTap, @required this.value})
      : super(key: key);

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        onTap: widget.onTap,
        activeOpacity: 0.2,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: widget.value
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).primaryColorLight),
            ),
          ),
        ));
  }
}

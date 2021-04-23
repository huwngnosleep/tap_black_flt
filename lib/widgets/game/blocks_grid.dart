import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tap_the_black/widgets/game/block.dart';

class BlocksGrid extends StatelessWidget {
  final List<int> blockKeys;
  final int blockNumber;
  final spacing;
  final chooseHandler;

  BlocksGrid(
      {@required this.blockKeys,
      @required this.blockNumber,
      @required this.spacing,
      @required this.chooseHandler});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.values[0],
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      crossAxisCount: sqrt(blockNumber).toInt(),
      children: blockKeys
          .map((item) => Block(
              onTap: () => chooseHandler(item == 4 ? true : false),
              value: item == 4 ? true : false))
          .toList(),
    );
  }
}

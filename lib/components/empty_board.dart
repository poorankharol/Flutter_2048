import 'dart:math';

import 'package:flutter/material.dart';

import '../const/colors.dart';

class EmptyBoardWidget extends StatelessWidget {
  const EmptyBoardWidget({super.key, required this.boardRow});

  final int boardRow;

  @override
  Widget build(BuildContext context) {
    //Decides the maximum size the Board can be based on the shortest size of the screen.
    final size = max(
        290.0,
        min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
            460.0));

    int row = boardRow;
    //Decide the size of the tile based on the size of the board minus the space between each tile.
    final sizePerTile = (size / row).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / row);
    final boardSize = sizePerTile * row;
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: boardColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        children: List.generate(
          row == 3 ? 9 : 16,
          (i) {
            //Render the empty board in 4x4 GridView
            var x = ((i + 1) / row).ceil();
            var y = x - 1;

            var top = y * (tileSize) + (x * 12.0);
            var z = (i - (row * y));
            var left = z * (tileSize) + ((z + 1) * 12.0);
            return Positioned(
              top: top,
              left: left,
              child: Container(
                width: tileSize,
                height: tileSize,
                decoration: BoxDecoration(
                  color: emptyTileColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

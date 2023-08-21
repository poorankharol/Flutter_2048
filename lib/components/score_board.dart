import 'package:flutter/material.dart';
import 'package:flutter_2048/managers/board_tiny.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/colors.dart';
import '../managers/board.dart';

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({super.key, required this.boardRow});

  final int boardRow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var score = ref.watch(boardManager.select((board) => board.score));
    // if (boardRow == 3) {
    //   score = ref.watch(boardManagerTiny.select((board) => board.score));
    // }
    var best = ref.watch(boardManager.select((board) => board.best));
    // if (boardRow == 3) {
    //   best = ref.watch(boardManagerTiny.select((board) => board.best));
    // }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Score(
          label: 'Score',
          score: '$score',
        ),
        const SizedBox(
          width: 50.0,
        ),
        Score(
          label: 'Best',
          score: '$best',
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ],
    );
  }
}

class Score extends StatelessWidget {
  const Score(
      {Key? key, required this.label, required this.score, this.padding})
      : super(key: key);

  final String label;
  final String score;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: scoreColor, borderRadius: BorderRadius.circular(8.0)),
      child: Column(children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 18.0, color: color2),
        ),
        Text(
          score,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
        )
      ]),
    );
  }
}

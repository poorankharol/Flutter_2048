import 'package:flutter/material.dart';
import 'package:flutter_2048/components/button_widget.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final _controller = PageController();
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  int boardRow = 4;

  final List<Widget> imgList = [
    // const Text(
    //   'Tiny (3x3)',
    //   style: TextStyle(
    //       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
    // ),
    const Text(
      'Classic (4x4)',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
    ),
  ];

  _onPageViewChange(int page) {
    setState(() {
      boardRow = page == 0 ? 3 : 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "2048",
                  style: TextStyle(
                    fontSize: 120,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: SizedBox(
                height: 50,
                width: 250,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        _controller.previousPage(
                            duration: _kDuration, curve: _kCurve);
                      },
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: imgList.length,
                          controller: _controller,
                          itemBuilder: (ctx, index) {
                            return Center(
                              child: imgList[index],
                            );
                          },
                          onPageChanged: _onPageViewChange,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      onPressed: () {
                        _controller.nextPage(
                            duration: _kDuration, curve: _kCurve);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ButtonWidget(
                      text: 'Start Game',
                      onPressed: () {
                        Navigator.pushNamed(context, 'game',
                            arguments: {'boardRow': boardRow});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ButtonWidget(
                      text: 'High Scores',
                      onPressed: () {
                        //Navigator.pushNamed(context, 'game');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

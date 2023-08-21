import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2048/game.dart';
import 'package:flutter_2048/game_tiny.dart';
import 'package:flutter_2048/start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/board_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  //Make sure Hive is initialized first and only after register the adapter.
  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.montserrat().fontFamily),
      title: '2048',
      initialRoute: 'start',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        'start': (context) => const Start(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'game': (context) => Game(),
      },
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == 'game') {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as Map;
          final row = args['boardRow'];
          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return row == 3
                  ? GameTiny(
                      boardRow: row,
                    )
                  : Game(
                      boardRow: row,
                    );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      home: const Start(),
    );
  }
}

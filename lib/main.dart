import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_library/COMPONENTS/button_view.dart';
import 'package:flutter_library/COMPONENTS/text_view.dart';
import 'package:flutter_library/MODELS/DATAMASTER/datamaster.dart';
import 'package:flutter_library/MODELS/coco.dart';
import 'package:flutter_library/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "lib/.env");
  final dm = DataMaster();
  runApp(const flutter_library());
}

class flutter_library extends StatelessWidget {
  const flutter_library({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            //
            ButtonView(
                child: TextView(
                  text: 'Press me coco',
                ),
                onPress: () async {
                  final mess = await coco_Send(
                      'What is your name?', 'Your name is Coco.', () {});
                  print(mess);
                })
          ],
        ),
      ),
    );
  }
}

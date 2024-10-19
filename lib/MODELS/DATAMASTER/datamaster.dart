import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_library/firebase_options.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_library/MODELS/constants.dart';
import 'package:flutter_library/MODELS/firebase.dart';

class DataMaster {
  String _theAppName = '';
  // Toggles
  bool _toggleLoading = false;
  bool _toggleAlert = false;
  bool _toggleBubble = false;

  bool get toggleLoading => _toggleLoading;
  bool get toggleAlert => _toggleAlert;
  bool get toggleBubble => _toggleBubble;

  void setToggleLoading(bool value) => _toggleLoading = value;
  void setToggleAlert(bool value) => _toggleAlert = value;
  void setToggleBubble(bool value) => _toggleBubble = value;

  // Strings
  String _alertTitle = "Alert Title";
  String _alertText = "Alert Text";

  String get alertTitle => _alertTitle;
  String get alertText => _alertText;
  String get theAppName => _theAppName;

  void setAlertTitle(String value) => _alertTitle = value;
  void setAlertText(String value) => _alertText = value;
  void setTheAppName(String value) => _theAppName = value;

  // Lists
  List<Widget> _alertButtons = [];

  List<Widget> get alertButtons => _alertButtons;

  void setAlertButtons(List<Widget> value) => _alertButtons = value;

  // User and Location Data
  Map<String, dynamic> _user = {};
  Map<String, dynamic> get user => _user;
  void setUser(Map<String, dynamic> value) => _user = value;

  LatLng _myLocation = LatLng(0, 0);
  LatLng get myLocation => _myLocation;
  void setMyLocation(LatLng value) => _myLocation = value;

  // Constructor
  DataMaster();

  // FUNCTIONS
  void getStarted() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await dotenv.load(fileName: "lib/.env");
  }

  Future<bool> checkUser(String table) async {
    print(theAppName);
    final user = await auth_CheckUser();
    print(user);
    if (user != null) {
      var userDoc =
          await firebase_GetDocument('${theAppName}_$table', user.uid);
      if (userDoc.isNotEmpty) {
        final token = await messaging_SetUp();
        final success = await firebase_UpdateDocument(
            '${theAppName}_$table', userDoc['id'], {'token': token});
        if (success) {
          userDoc = {...userDoc, 'token': token};
        }
        setUser(userDoc);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void praiseTheBagel() {
    setToggleAlert(true);
    setAlertTitle("All Hail Nothing.");
    setAlertText('Nothing rules over the Bagel.');
  }

  void alertSomethingWrong() {
    setAlertTitle('Uh Oh!');
    setAlertText('Something went wrong. Please try again.');
    setToggleAlert(true);
  }

  void alertMissingInfo() {
    setAlertTitle('Missing Info');
    setAlertText(
        'Please fill out all fields with the appropriate information.');
    setToggleAlert(true);
  }
}

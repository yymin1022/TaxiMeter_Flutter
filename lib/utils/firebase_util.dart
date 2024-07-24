import 'package:firebase_core/firebase_core.dart';
import 'package:taximeter/firebase_options.dart';

class FirebaseUtil {
  const FirebaseUtil();

  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  bool isUpdateAvail() {
    return false;
  }

  void updateCostInfo() {

  }
}
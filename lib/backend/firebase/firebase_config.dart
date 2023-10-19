import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDMv-Pwi1movMBAvo1-tZsjP3WdZD5KdNM",
            authDomain: "car-tracker-br.firebaseapp.com",
            projectId: "car-tracker-br",
            storageBucket: "car-tracker-br.appspot.com",
            messagingSenderId: "899208646112",
            appId: "1:899208646112:web:93bf1a023be152b782ef85",
            measurementId: "G-VKVDR9BZ1N"));
  } else {
    await Firebase.initializeApp();
  }
}

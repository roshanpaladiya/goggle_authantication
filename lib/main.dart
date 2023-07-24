import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_authentication/Authantication.dart';
import 'package:google_sign_in/google_sign_in.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Authantication.firebaseIns();
  runApp(
    const MaterialApp(
      home: GoggleAuthantication(),
    ),
  );
}

class GoggleAuthantication extends StatefulWidget {
  const GoggleAuthantication({super.key});

  @override
  State<GoggleAuthantication> createState() => _GoggleAuthanticationState();
}

class _GoggleAuthanticationState extends State<GoggleAuthantication> {
  User? user;
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goggle Authantication'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            user != null
                ? Text(user!.email ?? "")
                : const SizedBox(
                    height: 50,
                  ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async {
                final GoogleSignIn googleSignIn = GoogleSignIn();
                bool auth = await googleSignIn.isSignedIn();

                if (isAuth == false) {
                  user = await Authantication.signInWithGoogle();
                  print(user);
                  print(user!.email);
                  print(user!.displayName);
                  setState(() {
                    isAuth = true;
                  });
                }
                if (auth && isAuth) {
                  await Authantication.signOut();
                  user = null;
                  setState(() {
                    isAuth = false;
                  });
                }
              },
              child: Image.asset('asserts/images/goggle.png'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                User? user = await signInWithGoogle();
                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signed in as ${user.displayName}')),
                  );
                }
              },
              child: const Text("Sign in with Google"),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () async {
            //     User? user = await signInWithFacebook();
            //     if (user != null) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Signed in as ${user.displayName}')),
            //       );
            //     }
            //   },
            //   child: const Text("Sign in with Facebook"),
            // ),
          ],
        ),
      ),
    );
  }
}

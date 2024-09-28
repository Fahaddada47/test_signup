import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<User?> userFuture = signInWithGoogle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data != null) {
              final User? user = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Signed in as ${user!.email}'),
                  Text('Signed in as ${user!.displayName}'),
                  Text('Signed in as ${user!.photoURL}'),
                  const Text("You are signed in!"),
                ],
              );
            } else {
              // Handle the case where user is null (e.g., if sign-in failed)
              return const Text('User is not signed in.');
            }
          },
        ),
      ),
    );
  }
}

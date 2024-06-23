import 'package:facultad/providers/user_provider.dart';
import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
          // title: const Text(''),
          ),
      drawer: const DrawerListView(),
      body: Center(
        child: Text(
          user != null ? 'Welcome, ${user.username}!' : 'No user logged in',
        ),
      ),
    );
  }
}

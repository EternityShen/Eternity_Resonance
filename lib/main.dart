import 'package:flutter/material.dart';
import 'package:resonance/src/pages/home_page.dart';
import 'package:resonance/src/pages/settings_page.dart';
import 'package:resonance/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainShell(),
      themeMode: ThemeMode.dark,
    ),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomePage(), const SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.pink[200],
        height: 60,
        indicatorColor: Colors.pink[100],
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.settings), label: '设置'),
        ],
      ),
    );
  }
}

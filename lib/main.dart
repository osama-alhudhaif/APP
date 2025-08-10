import 'package:flutter/material.dart';
import 'pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Center(child: Text("الصفحة الرئيسية")),
    const Center(child: Text("الصفحة الثانية")),
    const Center(child: Text("الصفحة الثالثة")),
  ];

  void _onMenuItemSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'عوالمنا',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'This is a snackbar',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                );
              },
            ),
            // فئات القصص

            const SizedBox(width: 10),
            Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleSpacing: 0.0,
        toolbarOpacity: 0.6,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, color: Colors.white),
            onSelected: _onMenuItemSelected,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                key: const Key("account"),
                child: Row(
                  children: const [
                    Icon(Icons.account_circle_outlined, key: Key("icon")),
                    SizedBox(width: 8),
                    Text("الحساب"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                key: const Key("settings"),
                child: Row(
                  children: const [
                    Icon(Icons.account_circle_outlined, key: Key("icon")),
                    SizedBox(width: 8),
                    Text("الاعدادات"),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                key: Key("add_story"),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      key: Key("writing"),
                    ),
                    SizedBox(width: 8),
                    Text("اضافة قصة"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}

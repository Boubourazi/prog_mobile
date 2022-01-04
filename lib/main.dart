import 'package:flutter/material.dart';
import 'package:prog_mobile/widgets/campus_picker.dart';
import 'package:prog_mobile/widgets/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.grey)),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'UPPA Maps'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<String> imageUrls = [
    "assets/images/anglet_campus.jpg",
    "assets/images/pau_campus.jpg"
  ];
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: MediaQuery.of(context).size.height / 7,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: CampusPicker(imageUrls: widget.imageUrls),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

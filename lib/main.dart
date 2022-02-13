import 'package:flutter/material.dart';
import 'package:prog_mobile/widgets/embedded/campus_picker.dart';
import 'package:prog_mobile/widgets/page/campus_page.dart';
import 'package:prog_mobile/widgets/page/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:prog_mobile/logic/store.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:prog_mobile/logic/csv_parser.dart';

void main() {
  runApp(
    VxState(
      store: GlobalStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.grey),
        ),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'UPPA Maps'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  final List<Map<String, String>> imageUrls = [
    {"url": "assets/images/anglet_campus.jpg", "name": "Anglet"},
    {"url": "assets/images/pau_campus.jpg", "name": "Pau"},
    {"url": "assets/images/mdm_campus.jpg", "name": "Mont de Marsan"},
    {"url": "assets/images/bayonne_campus.jpg", "name": "Bayonne"}
  ];
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CsvParser parser = CsvParser("assets/data/exportbatimentsUPPA.csv");

  List<List<dynamic>>? data;

  @override
  void initState() {
    super.initState();
    parser.initParsed();
  }

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [ChangeCurrentCampus]);

    GlobalStore store = VxState.store;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/icon/1024.png"),
        actionsIconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: MediaQuery.of(context).size.height / 8,
        title: Text(
          widget.title,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
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
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  store.campus[store.currentCampus],
                  key: ValueKey<int>(store.currentCampus),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CampusPage(
                        imageInfo: widget.imageUrls[store.currentCampus],
                        parser: parser,
                      );
                    },
                  ));
                },
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  elevation: 10,
                  child: CampusPicker(
                    imageUrls: widget.imageUrls,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}

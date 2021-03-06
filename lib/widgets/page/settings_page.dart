import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool loaded = false;
  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs?.getBool("velo") == null) {
      _prefs!.setBool("velo", false);
    }
    if (_prefs?.getBool("geolocation") == null) {
      _prefs!.setBool("geolocation", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 8,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          "Paramètres",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: FutureBuilder(
        future: _initPrefs().then((_) => setState(() {
              loaded = true;
            })),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !loaded) {
            return const Center(child: CircularProgressIndicator());
          }
          var velo = _prefs?.getBool("velo") ?? true;
          return ListView(
            children: <Widget>[
              SwitchListTile(
                  secondary: AnimatedCrossFade(
                    crossFadeState: velo
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                    firstChild: const Icon(
                      Icons.directions_walk,
                      size: 45,
                    ),
                    secondChild: const Icon(
                      Icons.pedal_bike,
                      size: 45,
                    ),
                  ),
                  title: Text(
                    velo ? "Vélo" : "Piéton",
                    style: const TextStyle(fontSize: 20),
                  ),
                  value: _prefs?.getBool("velo") ?? true,
                  onChanged: (value) {
                    _prefs!.setBool("velo", value);
                    setState(() {});
                  }),
              SwitchListTile(
                value: _prefs?.getBool("geolocation") ?? true,
                onChanged: (value) {
                  _prefs!.setBool("geolocation", value);
                  setState(() {});
                },
                title: const Text(
                  "Géolocalisation",
                  style: TextStyle(fontSize: 20),
                ),
                secondary: const Icon(
                  Icons.location_on,
                  size: 45,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

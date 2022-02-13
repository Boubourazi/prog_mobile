import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prog_mobile/logic/csv_parser.dart';
import 'dart:convert' show utf8;
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampusPage extends StatelessWidget {
  final Map<String, String>? imageInfo;
  final CsvParser? parser;
  const CampusPage({
    Key? key,
    @required this.imageInfo,
    @required this.parser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: imageInfo!["name"]!,
            child: Image.asset(imageInfo!["url"]!),
          ),
          Text(
            imageInfo!["name"] ?? "default value",
            style:
                GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
            future: parser!.initParsed(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: parser!
                        .siteByCampus[imageInfo!["name"]!.toUpperCase()]!
                        .length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(parser!.siteByCampus[
                                imageInfo!["name"]!.toUpperCase()]![index]["id"]
                            .toString()),
                        trailing: (parser!.siteByCampus[imageInfo!["name"]!
                                        .toUpperCase()]![index]["lat"]
                                    .toString()
                                    .isNotEmpty &&
                                parser!.siteByCampus[imageInfo!["name"]!
                                        .toUpperCase()]![index]["long"]
                                    .toString()
                                    .isNotEmpty)
                            ? const Icon(Icons.arrow_right)
                            : null,
                        onTap: () async {
                          AndroidIntent intent = AndroidIntent(
                            data:
                                "google.navigation:q=${parser!.siteByCampus[imageInfo!["name"]!.toUpperCase()]![index]["long"].toString()},${parser!.siteByCampus[imageInfo!["name"]!.toUpperCase()]![index]["lat"].toString()}&mode=b",
                            package: "com.google.android.apps.maps",
                            action: 'action_view',
                          );
                          await intent.launch();
                        },
                        title: Text(
                          parser!.siteByCampus[imageInfo!["name"]!
                                  .toUpperCase()]![index]["name"]
                              .toString(),
                          style: GoogleFonts.roboto(fontSize: 17),
                        ),
                      );
                    },
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

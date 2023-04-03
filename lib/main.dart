import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(RephrazerApp());
}

class RephrazerApp extends StatelessWidget {
  const RephrazerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  static const apikey = ""; // replace with yout openai api key

  // Uri endpoint = 'https://api.openai.com/v1/completions' as Uri;
  Uri endpoint = Uri.parse('https://api.openai.com/v1/completions');
  // bad end point https://api.openai.com/v1/engines/davinci/completions

  // Future APIKEY = confiq()
  //     .then(((value) => print(value)))
  //     .catchError((error) => print(error));
  static const APIKEY = String.fromEnvironment('apikey');

  Future<String> generateText(String prompt) async {
    try {
      var response = await http.post(
        endpoint,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $apikey",
          HttpHeaders.acceptHeader: "application/json",
        },
        body: json.encode(
            {'model': 'text-davinci-003', 'prompt': prompt, 'max_tokens': 256}),
      );

      if (response.statusCode == 200) {
        final resposeBody = json.decode(response.body);
        print(resposeBody);
        print(resposeBody['choices']);
        String text = resposeBody['choices'][0]['text'];
        print(text);
        return text;
      } else {
        throw response.statusCode;
      }
    } catch (error) {
      print(error);
    }
    return response.text;
  }

  late String gent;
  TextEditingController userSentence = TextEditingController();
  TextEditingController response = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REPHRAZER APP")),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "INPUT SENTENCE TO REPHRAZE",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white, border: InputBorder.none),
                    maxLines: 6,
                    controller: userSentence,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 100,
              child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () async {
                    print('before request ...');
                    print('rephrase ${userSentence.text}');
                    String req = "Rephrase ${userSentence.text}";
                    gent = await generateText(req.trim());
                    print('after request ...');
                    print(gent);
                    setState(() {
                      response.text = gent;
                    });
                    print('after set state ...');
                  },
                  child: Center(child: Text("Rephraze"))),
            ),
            // TextFormField(

            //   controller: response,
            //   readOnly: true,
            // )
            Text(
              response.text,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

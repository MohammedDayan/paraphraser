import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:flutter_chatgpt_api/flutter_chatgpt_api.dart';

// const SESSION_TOKEN =
//     'eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..ncN37l5umEE8E-2F.5CXl3NeU_lp-5R-es3BVZyl6S3Q6uH4-sI7d7Hz8kDnQNqEuhL-le0xup5rDDXoiPhaZf2V4qOln3wlQFXJKRLvEwfW1LiWzocPjU4JAqt5GEEQTk18iPKDpipV2nRjDObkqyqSPIZRZ13Uecvr40gDHw2vIYkd6r7h8Z8-RIRkdLJ2i8b8zS1ZY-MxAKnt7L8S5eet7Mm-8sjeAn1HrBdiAYncu6MlOJ8GzzqKDevR8vY6qhUo_mC_O4hIfLgY0Wb_IY6iND3-4bgI9bJWBdLzT0aP9vM-p2gPn5NIjkMMa-FdP0oICnzMEQ-v0Gwb-kiDMCUbGWEFKyjbMDfrA3igKSdd48lWWjMNf6DRjI_w5HEv7mXHqQBwCyXUHUWXWBDXKeFGkMIqzRjo-b9fY9PEe9lTqYt4Oh8HG2qHTjUXCZcD9TyV4JE1UyVBkxf8t2lR0O0Al4dKwmUpliDAswmIpEz-IssZmJB9jhAVWnaHdyjNYXkcwSOCTbPC8VVFjqPc5aoNO2qH0ksnWL1TFyYU3wP3ElpTiPnaiAR73aexJ4F0IKy7XoG3t6PHoEauk8jv-UFDKRXkjYpL9JFQPdXmpXIsVM4e2HA6n5_ti471tloKnuTAKQX4Q1nCRucq3a-otbfMl7-QJvrYiSNSFOMrztq-DAfnsnd3W8q1s-rhRMNT0nUK5gSocNLF3iFX8iYhVTQuSx7SDZazKDH8oNi1-6svTYIVE46Pmlnfy_lk1Uq2ztREqZI-laitmNFA_iUzuyyudvVA-4U4p-Szi6vOJ6Vc4BfihFD6WoiWh5q9B6yOA0xvTTaKRwhmXyrK4CbNzsL9GvSS_dbeoMrh3304v6ymlH6B4BEIU0gfPcE4MQic3ifVddIVyLnRSg5naSAOXPMBHKYUHsPxTqZiOX4rkmS6Su8-67mSApsMKUOjnKEgd2RhJDwF4wvvcIt4kBWPLEDGNLYrgom0mqam0nSo-6FP5G8R2cIaOenEI_iVkjbE-pYNZbPvFc_QqDlBUKlfy3ZdEJSKdxT4qTUQ10JFkE4X4OJiDaYXkxq8mVvsk0peQ9daDubj9hR1C-JzbSBvkj2Qgncpt_gvJcynswbzwwVbOPlEtZ8-M9jxcYfQz1d68SESK8gkZ6RyBxrLcCoBWOoVfU6qalGqRF84s-Syq78EIusofDppIX8zZeXdYJ-qkJqAZOwZhugamdhniLHgcxzqogQ7adKlW7llkkFW0NEpG0u1zA8AhglCyvAHQxBZmHBAlRhQOv_oaly6st0Z5TVZUlEIta5_FzDtn97v5SlIBU1024NN4Hl2hMlllH4ipOFWJoUnUq7Aaeqv_b9ptXk0w2nLpRt4I2Gqp41Cwqk3YOn8RK7PZoSLPtOj_6nf-PQze0xKZ35FBISH1M-dibMdHAlAm3f5KPR93AEK-88e0BDW575bJST-WhkStCXNGEx0dl-IJFnpwYAuTdCBSYQqjpjJfU_2MlnMGzF2TfVO-kQXbsc_rgKzYXmR-Me9H_MpknBK_9pQVpt7atFE6IF3c7Gg8jZRuOEepf6TrUyldtlp21jS_F-Lcg-GaHiC4R7CbAXqERRgqmRXXcS7faX6CV5I6dWGIZL2mDiHJs0B3FR01paU6B3VTlm6cifnSTUl6j-FIz05HBpHekFGXEZ0g_NU7gnzIxcTEd1_81f5Llu_MUp9dA1ZDnsN7G6g4VoIJnojqCKsimxTCfJ9uEpANa8mlqufopemJlm0CUFoeeRxTnwV1nBHQ08Ip0NFvGnxel1v-u--L8h1gh8YVqdxEkDfpQ1ypxa-CH8Uhc2609OgyV2YADAmhjRstz20qJC57tM3eH4XZxY4Twju6kpjGf-YMRwEGRfQRPrO28ap87j0PeuHi6JsrlXaLUtH5iLs1JS_w0znU2HoYjA8eXWMkiOlwSGOOi4Jqxm_7H7LljoEXqN0FCKvXdDRxV41u3QrGqF12QWOQlDNHZlbJ06E80PHvtRuNJkJnO2xHPGtOiuYoc7XvTaeqm8dDGYtOm6NEWpOcnq1U0_JbulT_JQSY6ajSxY1DaSpupXbU6eW2uo-o54tlL0BbFm3lbY-37SwjNEpHFfOErBzU8RwimWoYfAKgiCzmr4m_JY9giMyhy1udTIZE_b-JJzAqm5uvpyy_5Z7XaV0WpSv4oM5Q9DHUD2xu6mvSIvPYS3_gFxpuMVBU_iDRdZHYBjsY8ZXP6xq9unHrfOWRL86_F9We43oHZYCvkHJqSd1sYIk85bJdkx29y2C1o7iranA0xSCsHxLmf1XRL4bR5JvoC-TB8A.jQXd_CX9WI0L9XZjQXaWVg';
// const CLEARANCE_TOKEN =
//     'fqQBzXXGHKSndqWS0mJHghHm.YtQaCfwFMNAhwojU2A-1672596027-0-1-2651cb6.390ebcae.118ff98f-160';

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
  // ChatGPTApi _api =
  //     ChatGPTApi(sessionToken: SESSION_TOKEN, clearanceToken: CLEARANCE_TOKEN);

  static const apikey = "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";

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

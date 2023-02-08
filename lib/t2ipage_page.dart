import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class t2ipage extends StatefulWidget {
  t2ipage({super.key});
  var imgback;
  @override
  State<t2ipage> createState() => _t2ipageState();
}

class _t2ipageState extends State<t2ipage> {
  var img;
  static final cachemanage = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
      fileService: HttpFileService(),
    ),
  );
  var go = 2;
  var api = "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";
  TextEditingController save = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              height: 2000,
              width: 2000,
              child: Image.asset(
                'assets/web9.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(wid * 0.1, height * 0.03, wid * 0.15, 0),
              child: TextField(
                cursorColor: Colors.pink,
                style: TextStyle(color: Colors.pinkAccent),
                controller: save,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(wid * 0.88, height * 0.06, 0, 0),
              child: IconButton(
                onPressed: () async {
                  print('da');
                  var url = await Uri.parse(
                      "https://api.openai.com/v1/images/generations");

                  var header = {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer $api"
                  };
                  try {
                    setState(() {
                      go = 0;
                    });
                    print(save.text);
                    var response = await http.post(url,
                        headers: header,
                        body: jsonEncode(
                            {'prompt': save.text, 'n': 1, 'size': '1024x1024'}));
                    img = jsonDecode(response.body)['data'][0]['url'];
                    print(img);
                    setState(() {
                      go = 1;
                    });
                  } on HttpException catch (e) {
                    print(e.message);
                  }
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
              ),
            ),
            if (go == 1)
              CachedNetworkImage(
                imageUrl: img,

                key: UniqueKey(),
                imageBuilder: (context, imageProvider) => Padding(
                  padding: EdgeInsets.fromLTRB(wid * 0.13, height * 0.15, 0, 0),
                  child: Container(
                    height: 1200,
                    width: 1000,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                cacheManager: cachemanage,
                placeholder: (context, img) => Padding(
                  padding: EdgeInsets.fromLTRB(wid * 0.5, height * 0.5, 0, 0),
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey,
                    strokeWidth: 2,
                  ),
                ),
              )
            else if (go == 0)
              Padding(
                padding: EdgeInsets.fromLTRB(wid * 0.5, height * 0.5, 0, 0),
                child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                  strokeWidth: 2,
                ),
              )
          ]),
        ));
  }
}

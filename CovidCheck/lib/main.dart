import 'dart:ui'; // no use
import 'package:flutter/services.dart';
import 'dart:async'; //streamsubs
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart'; //every gui
import 'package:flutter/cupertino.dart'; //no use
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/platform_interface.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _storage = const FlutterSecureStorage();
  static Map<String, String> _items;
  static String name = '';
  static String pass = '';
  static int myvar = 1;
  TextEditingController nameController;
  TextEditingController passwordController;

  _MyHomePageState() {
    _readAll();
    nameController = TextEditingController(text: name);
    passwordController = TextEditingController(text: pass);
  }

  Future<void> _readAll() async {
    try {
      _items = await _storage.readAll(
          aOptions: AndroidOptions(encryptedSharedPreferences: true));
      if (_items.isEmpty == false && myvar == 1) {
        name = _items.keys.first;
        pass = _items.values.first;
        nameController = TextEditingController(text: name);
        passwordController = TextEditingController(text: pass);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
        myvar = 0;
      } else {
        name = '';
        pass = '';
      }
    } catch (exp) {}
  }

  void _addNewItem() async {
    final String key = name;
    final String value = pass;
    try {
      await _storage.write(
          key: key,
          value: value,
          aOptions: AndroidOptions(encryptedSharedPreferences: true));
    } catch (exp) {}
  }

  String validatePassword(String value) {
    if ((value == null || value == '') ? true : false) {
      return "Enter Name And Password For First Login";
    }
    return 'Autologin Press Login Button';
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      // floatingActionButton: UnicornDialer(
      //     parentButtonBackground: Colors.blueGrey.withOpacity(0.1),
      //     parentHeroTag: 'Follow us',
      //     orientation: UnicornOrientation.VERTICAL,
      //     parentButton: Icon(Icons.navigation),
      //     childButtons: floatingButtons),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.nationdrivingschool.com/uploads/files/cv_1.png'),
                fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.blueAccent[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'The CoVIApp',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                )),
            Container(
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20, fontFamily: 'Satisfy'),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12)),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  errorText: validatePassword(nameController.text),
                  errorStyle: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  labelText: 'Your Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 15, 10),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: validatePassword(passwordController.text),
                  errorStyle: TextStyle(
                    color: Colors.blueAccent[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  labelText: 'Your Password',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                autofocus: false,
                child: const Text('Login Now'),
                onPressed: () {
                  pass = passwordController.text;
                  name = nameController.text;
                  if (name == "") {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MidClass()));
                  }
                  _addNewItem();
                },
              ),
            ),
            Container(
                child: const Text(
                  'Device Internet Status',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12)),
            OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      (connectivity == ConnectivityResult.wifi ||
                          connectivity == ConnectivityResult.mobile);
                  return new Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        color:
                            connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                        child: Center(
                          child: Text(
                              "${connected ? 'You are ONLINE' : 'You are OFFLINE Check Internet'}"),
                        ),
                      ),
                    ],
                  );
                },
                child: Text("")),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '          @ Copyright 2022 to MiniProject@Sastra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }

  String fun() {
    return name;
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Text(
                  "CoVIApp",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              image: DecorationImage(
                image: NetworkImage(
                    'https://technicalpuruji.com/wp-content/uploads/2019/06/website-background-images-light-color-background-images-for-websites-040.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            selectedTileColor: Colors.cyan,
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_system_daydream_outlined),
            title: Text('CoVICheck'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Second()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () => {SystemNavigator.pop()},
          ),
        ],
      ),
    );
  }
}

class Second extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<Second> {
  String myst;
  final myControl = TextEditingController();
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final _dataService = DataMain();
  @override
  void dispose() {
    myController.dispose();
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.nationdrivingschool.com/uploads/files/cv_1.png'),
                fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.blueAccent[300],
        title: Text("CoVICheck",
            style: TextStyle(color: Colors.tealAccent, fontSize: 15)),
      ),
      drawer: SideDrawer(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: NetworkImage(
                    'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/2c9b4193978513.5e72de2275a73.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Enter Name',
                      hintText: 'Enter Your Name'),
                  controller: myControl,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Age',
                      hintText: 'Enter Your Age'),
                  controller: myController,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'WBC',
                      hintText: 'Enter WBC Value'),
                  controller: myController1,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Lymphocytes',
                      hintText: 'Enter Lyt Name'),
                  controller: myController2,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Monocytes',
                      hintText: 'Enter Lyt Name'),
                  controller: myController3,
                ),
                if (myst != null && myst.contains("positive"))
                  Container(
                      child: Text(
                    '                             RESULTS\n\n\n Mr/Mrs ${myControl.text} $myst',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
                if (myst != null && myst.contains("negative"))
                  Container(
                      child: Text(
                    '                             RESULTS\n\n\n Mr/Mrs ${myControl.text} $myst',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
                if (myst != null &&
                    !myst.contains("negative") &&
                    !myst.contains("positive"))
                  Container(
                      child: Text(
                    '                             RESULTS\n  $myst',
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  )),
                FlatButton(
                    minWidth: 50,
                    height: 40,
                    color: Colors.yellow,
                    onPressed: () async => {
                          _search(),
                          await Future.delayed(
                              const Duration(seconds: 2), () {})
                        },
                    child: Text("Submit Form"))
              ])),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '          @ Copyright 2022 to MiniProject@Sastra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getCov(myController.text,
        myController1.text, myController2.text, myController3.text);

    myst = response;
    print(myst);
    setState(() => myst = response);
  }
}

class DataMain {
  Future getCov(String a, String w, String l, String m) async {
    final httpsUri = Uri(
        scheme: 'http',
        host: '18.236.70.216',
        path: '/predict',
        queryParameters: {'a': a, 'w': w, 'l': l, 'm': m});
    print(httpsUri);

    final response = await http.get(httpsUri);

    String rr = response.body;
    return rr;
  }
}

class CoviNews extends StatefulWidget {
  @override
  _CoviNews createState() => _CoviNews();
}

class _CoviNews extends State<CoviNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.nationdrivingschool.com/uploads/files/cv_1.png'),
                fit: BoxFit.cover),
          ),
        ),
        title: Text("CoVINews",
            style: TextStyle(color: Colors.tealAccent, fontSize: 15)),
        backgroundColor: Colors.blueAccent[100],
      ),
      drawer: SideDrawer(),
      body: WebView(
        onWebResourceError: (WebResourceError webviewerrr) {
          print("We will recover soon. Sorry for the inconvenience");
        },
        initialUrl: "https://www.mohfw.gov.in/",
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          print('Page finished loading:');
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '          @ Copyright 2022 to MiniProject@Sastra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }
}

class MidClass extends StatefulWidget {
  @override
  _MidClass createState() => _MidClass();
}

class _MidClass extends State<MidClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.nationdrivingschool.com/uploads/files/cv_1.png'),
                fit: BoxFit.cover),
          ),
        ),
        title: Text("CoVIApp",
            style: TextStyle(color: Colors.tealAccent, fontSize: 15)),
        backgroundColor: Colors.blueAccent[100],
      ),
      drawer: SideDrawer(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: NetworkImage(
                    'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/2c9b4193978513.5e72de2275a73.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                  color: Colors.amber,
                  child: Text(
                    "CoVINews",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onPressed: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CoviNews()))
                      }),
              FlatButton(
                  color: Colors.limeAccent,
                  child: Text(
                    "CoVICheck",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  onPressed: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Second()))
                      })
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '          @ Copyright 2022 to MiniProject@Sastra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }
}

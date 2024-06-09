//@dart=2.9
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:async'; //streamsubs
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart'; //every gui
import 'package:flutter/cupertino.dart'; //no use
import 'package:flutter/widgets.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:web_browser/web_browser.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "MyKey",
        channelName: "News",
        channelDescription: "Notification",
        enableLights: true,
        enableVibration: true,
        importance: NotificationImportance.Max,
        defaultColor: Colors.grey,
        playSound: true)
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash2(),
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new MyHomePage(),
      title: new Text(
        'The News App',
        textScaleFactor: 2,
      ),
      image: new Image.asset('assets/11.jpg'),
      loadingText: Text(
        "DivineIndra Apps Network",
        style: TextStyle(fontSize: 20),
      ),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var session = FlutterSession();
  static int reg;
  static String items;
  static String name;
  static String pass;
  TextEditingController nameController;
  TextEditingController passwordController;
  _MyHomePageState() {
    nameController = TextEditingController(text: name);
    passwordController = TextEditingController(text: pass);
  }
  String ret() {
    if (items == null)
      return name;
    else
      return items;
  }

  StreamSubscription<ReceivedAction> _val;
  void listen() async {
    _val = AwesomeNotifications().actionStream.listen((receivedNotification) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Second()));
    });
  }

  @override
  dispose() {
    Future.delayed(Duration.zero, () async {
      await _val?.cancel();
    });
    super.dispose();
  }

  Future<void> _readAll() async {
    try {
      items = await session.get("name");
      listen();
      print(items);
      if (mounted && items != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MidClass()));
      }
    } catch (exp) {
      print("Exception in fetching value $exp");
    }
  }

  mine() async {
    reg = 1;
    heat(context);
    await launch(
            "https://api.elasticemail.com/form?lid=yc3RXclY0sRhUjO4xufM1g2")
        .then((value) {
      print(value);
    }).catchError((err) => print(err));
  }

  void _addNewItem() async {
    try {
      await session.set("name", name);
    } catch (exp) {
      print("Exception in saving the data");
    }
  }

  void notify() async {
    String tt = await AwesomeNotifications()
        .getLocalTimeZoneIdentifier(); //get time zone you are in

    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'MyKey',
          title: 'News App',
          body: 'क्या कर रहे हैं? मस्ती करना बंद करें और पढे नवीनतम समाचार',
          bigPicture:
              'https://gumlet.assettype.com/swarajya%2F2016-02%2F411037c6-d91b-48a6-8d4e-ddc85729555f%2Findian-media-channels.jpg?q=75&auto=format%2Ccompress&w=640&dpr=0.8',
          notificationLayout: NotificationLayout.BigPicture),
      schedule:
          NotificationInterval(interval: 8000, timeZone: tt, repeats: true),
    );
  }

  @override
  initState() {
    _readAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.freeimages.com/images/large-previews/a1b/the-sun-1396604.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        title: Text(
          "Latest News",
          style: TextStyle(fontSize: 25, color: Colors.black),
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
                  'News',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                )),
            Container(
                height: 150,
                child: const Text(
                  'First Click on Register and fill the form in Web Browser then come back to the App '
                  'Enter Your Name and Email and Start the App',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12)),
            Container(
              color: Colors.blue,
              child: FlatButton(
                  child: Text(
                    "Click to Register",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => mine()),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'आपका शुभ नाम(Max 15 letters)',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 15, 10),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'ईमेल',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                autofocus: false,
                child: const Text('Login'),
                onPressed: () {
                  pass = passwordController.text;
                  name = nameController.text;
                  if (name != null &&
                      name != '' &&
                      pass != null &&
                      pass != '' &&
                      reg == 1) {
                    _addNewItem();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MidClass()));
                  } else {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '                           @ Copyright 2022 to Divineindra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }

  void heat(BuildContext k) {
    Widget okButn = FlatButton(
      child: Text('OK ठीक है '),
      onPressed: () {
        Navigator.of(k, rootNavigator: true).pop();
      },
    );

    AlertDialog a = AlertDialog(
      backgroundColor: Colors.blue[100],
      title: Text('समाचार App के लाभ'),
      content: Text('बिना किसी Advertisement के समाचार' +
          '                              ' +
          'सिर्फ एक बार login की सुविधा ' +
          '                              ' +
          'बहुत सारे समाचार की websites उपलब्ध'
              '                         ' +
          'स्वचालित Youtube Video पर पाबंदी'
              '                             ' +
          'आपकी निजता की रक्षा' +
          '                            ' +
          'Internet ऑन/ऑफ की सांकेतिक बटन'),
      actions: [
        okButn,
      ],
    );

    showDialog(
        context: k,
        builder: (BuildContext context) {
          return a;
        });
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
              alignment: Alignment.center,
              child: Container(
                child: Text(
                  "News",
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/premium-vector/seven-chakras-line-icons-set_74102-1403.jpg?size=338&ext=jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            selectedTileColor: Colors.cyan,
            leading: Icon(Icons.home),
            title: Text('News'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MidClass()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_system_daydream_outlined),
            title: Text('Current Affairs'),
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
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<Second> {
  static int val;
  int fun() {
    return val;
  }

  transaction() async {
    String upi =
        'upi://pay?pa=divineindra@okicici&pn=Divineindra Apps&tn=Donation&cu=INR';
    await launch(upi).then((value) {
      print(value);
    }).catchError((err) => print(err));
  }

  String name = _MyHomePageState().ret();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          const url = "https://www.linkedin.com/in/aditya-pandey-0a3668190/";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'could not launch';
          }
        },
        icon: Image.asset("assets/logo.png"),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.livenewsweb.com/wp-content/uploads/2019/10/indian-tv-livenewsweb.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.blueAccent[100],
      ),
      drawer: SideDrawer(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                color: Colors.blue,
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    "स्वागतम $name जी",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
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
                      color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Text(
                          "${connected ? 'ONLINE' : 'OFFLINE'}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Text("Internet Status"),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                val = 1;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CoviNews()));
              },
              child: Container(
                alignment: Alignment.topCenter,
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://hindi.gktoday.in/wp-content/themes/groovy/images/gktoday-hindi-new-logo.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Text(
                  "GKTODAY",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                val = 2;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CoviNews()));
              },
              child: Container(
                alignment: Alignment.topCenter,
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://wpassets.adda247.com/wp-content/uploads/multisite/sites/9/2022/09/07120051/cropped-Current-Affairs.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  "ADDA 24|7",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  val = 3;
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CoviNews()));
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.chronicleindia.in/images/logo.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(
                    "Chronicle",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    val = 4;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CoviNews()));
                  },
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://www.insightsonindia.com/wp-content/uploads/2023/02/insightslogo.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(
                        "InsightsIAS",
                        style: TextStyle(fontSize: 18),
                      )))
            ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 100,
                width: 180,
                child: Column(
                  children: [
                    Text("Watch On Youtube Network"),
                    FlatButton(
                      onPressed: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MNews()))
                      },
                      child: Image(
                        image: NetworkImage(
                            "https://info.shimamura.co.jp/drums/img/bside/youtube.png"),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '                           @ Copyright 2022 to Divineindra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }
}

class MidClass extends StatefulWidget {
  @override
  _MidPageState createState() => _MidPageState();
}

class _MidPageState extends State<MidClass> {
  static int val;
  int fun() {
    return val;
  }

  transaction() async {
    String upi =
        'upi://pay?pa=divineindra@okicici&pn=Divineindra Apps&tn=Donation&cu=INR';
    await launch(upi).then((value) {
      print(value);
    }).catchError((err) => print(err));
  }

  String name = _MyHomePageState().ret();
  @override
  Widget build(BuildContext context) {
    _MyHomePageState().notify();
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          const url = "https://www.linkedin.com/in/aditya-pandey-0a3668190/";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'could not launch';
          }
        },
        icon: Image.asset('assets/logo.png'),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.livenewsweb.com/wp-content/uploads/2019/10/indian-tv-livenewsweb.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.blueAccent[100],
      ),
      drawer: SideDrawer(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                color: Colors.blue,
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    "स्वागतम $name जी",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
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
                      color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                      height: 50,
                      width: 200,
                      child: Center(
                        child: Text(
                          "${connected ? 'ONLINE' : 'OFFLINE'}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Text("Internet Status"),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                val = 1;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CovNews()));
              },
              child: Container(
                alignment: Alignment.topCenter,
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.exchange4media.com/news-photo/100947-expresslogo.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  "The Indian Express",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                val = 2;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CovNews()));
              },
              child: Container(
                alignment: Alignment.topCenter,
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://thestoryof.org/wp-content/uploads/2018/01/TheHindu-Logo-300x225.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  "The Hindu",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  val = 3;
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => CovNews()));
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.firstpost.com/wp-content/uploads/2017/04/News18-India.jpg?impolicy=website&width=640&height=362',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(
                    "News18 इंडिया",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    val = 4;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CovNews()));
                  },
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://newsonair.gov.in/hindi/App_Themes/Theme1/images/logo.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(
                        "Samaachar Seva",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )))
            ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 100,
                width: 180,
                child: Column(
                  children: [
                    Text("You can support me here"),
                    FlatButton(
                      onPressed: () => transaction(),
                      child: Image(
                        image: NetworkImage(
                            "https://media.msufcu.org/publicsites/publicsite/graphics/googlepaylogo.png"),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '                           @ Copyright 2022 to Divineindra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }
}

class CoviNews extends StatefulWidget {
  @override
  _CoviNews createState() => _CoviNews();
}

class _CoviNews extends State<CoviNews> {
  static String url;
  int val = _SecondPageState().fun();
  void modify() {
    if (val == 1)
      url = "https://hindi.gktoday.in/hindi-current-affairs/";
    else if (val == 2)
      url = "https://hindicurrentaffairs.adda247.com/";
    else if (val == 3)
      url = "https://www.chronicleindia.in/";
    else if (val == 4)
      url =
          "https://www.insightsonindia.com/insights-ias-upsc-current-affairs/";
    else
      url = "";
  }

  @override
  Widget build(BuildContext context) {
    modify();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://s3.envato.com/files/127924075/National%20Symbols%20for%20PowerPoint%20Screenshots/India.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.blueAccent[100],
      ),
      drawer: SideDrawer(),
      body: WebBrowser(
        interactionSettings: WebBrowserInteractionSettings(
            topBar: null,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                .require_user_action_for_all_media_types),
        initialUrl: url,
        javascriptEnabled: false,
        debuggingEnabled: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '                           @ Copyright 2022 to Divineindra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }
}

class CovNews extends StatefulWidget {
  @override
  _CovNews createState() => _CovNews();
}

class _CovNews extends State<CovNews> {
  static String url;
  int val = _MidPageState().fun();
  void modify() {
    if (val == 1)
      url = "https://indianexpress.com/";
    else if (val == 2)
      url = "https://www.thehindu.com/";
    else if (val == 3)
      url = "https://hindi.news18.com/";
    else if (val == 4)
      url = "https://newsonair.gov.in/hindi/Hindi-Default.aspx";
    else
      url = "";
  }

  @override
  Widget build(BuildContext context) {
    modify();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://s3.envato.com/files/127924075/National%20Symbols%20for%20PowerPoint%20Screenshots/India.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.blueAccent[100],
      ),
      drawer: SideDrawer(),
      body: WebBrowser(
        interactionSettings: WebBrowserInteractionSettings(
            topBar: null,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                .require_user_action_for_all_media_types),
        initialUrl: url,
        javascriptEnabled: false,
        debuggingEnabled: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '                           @ Copyright 2022 to Divineindra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }
}

class MNews extends StatefulWidget {
  @override
  _MNews createState() => _MNews();
}

class _MNews extends State<MNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      body: WebBrowser(
        interactionSettings: WebBrowserInteractionSettings(
            topBar: null,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow),
        initialUrl: "https://newstvonline.com/language-tv-channels/hindi/",
        javascriptEnabled: true,
        debuggingEnabled: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '                           @ Copyright 2022 to Divineindra',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
      ),
    );
  }
}

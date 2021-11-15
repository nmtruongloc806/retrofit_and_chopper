import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:retrofit_and_chopper/api.dart';
import 'package:retrofit_and_chopper/api_service.dart';
import 'package:retrofit_and_chopper/app_settings.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.innitAppSetting();

  AppSettings.setValue(KeyAppSetting.userName, 'tunghoang');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiService apiService;
  final Logger logger = Logger();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initApi();
  }

  void initApi() async {
    print('initApi');
    Dio dio = await Api().getDio();
    apiService = ApiService(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => callApi("getThongKeVanBanDen"),
                child: Text("GetThongKeVanBanDenDashboard"))
          ],
        ),
      ),
    );
  }

  void callApi(String key) async {
    Dio dio = await Api().getDio();
    apiService = ApiService(dio);
    switch (key) {
      case "getThongKeVanBanDen":
        var result = await apiService.getThongKeVanBanDen(
            "", 1787, 'tunghoang', 12395, 1);
        logger.d(result.toJson().toString());
        break;
    }
  }
}

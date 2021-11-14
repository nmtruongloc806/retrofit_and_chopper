import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:dio/adapter.dart';
import 'package:retrofit_and_chopper/app_settings.dart';
import 'package:retrofit_and_chopper/constant.dart';

class Api {
  late Dio _dio;

  String PEM = "XXXXX"; // certificate content
  String PKCS12File = "XXXXX"; // certificate content

  Future<Dio> getDio() async {
    var options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    print("getDio");
    _dio = new Dio(options);
    _dio.interceptors.add(AuthInterceptor()); // token
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true)); //添加日志
    //thêm https  setHttpsPEM(),etHttpsPKCS12()
    //  setFindProxy()
    return _dio;
  }

  setHttpsPEM() async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        if (cert.pem == PEM) {
          // Verify the certificate
          return true;
        }
        return false;
      };
    };
  }

  setHttpsPKCS12() async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext sc = new SecurityContext();
      //file is the path of certificate
      sc.setTrustedCertificates(PKCS12File);
      HttpClient httpClient = new HttpClient(context: sc);
      return httpClient;
    };
  }

  setFindProxy() async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY localhost:8888";
      };
      // you can also create a new HttpClient to dio
      // return new HttpClient();
    };
  }
}

class AuthInterceptor extends Interceptor {
  String PLATFORM = "android";

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    if (Platform.isIOS) {
      PLATFORM = "ios";
    } else if (Platform.isAndroid) {
      PLATFORM = "android";
    } else if (Platform.isWindows) {
      PLATFORM = "Windows";
    } else if (Platform.isMacOS) {
      PLATFORM = "macos";
    } else if (Platform.isLinux) {
      PLATFORM = "Linux";
    }

    Map<String, String> headers = new Map();
    headers["Accept-Charset"] = "utf-8";
    headers["Connection"] = "keep-alive";
    headers["Accept"] = "*/*";
    headers["x-version"] = version;
    headers["x-platform"] = PLATFORM;

    //header token
    String? token = AppSettings.getValue(KeyAppSetting.token);
    print("xxxxxxxxxx");
    print(token);
    if (null != token && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    else{
      var dataToken = await getTokenFromServer();
      print("xxxxxxxxxx 2 2");
      token = dataToken["access_token"];
      AppSettings.setValue(KeyAppSetting.token, token);
      print(token);
      headers["Authorization"] = "Bearer $token";
    }

    options.headers = headers;
    return super.onRequest(options, handler);
  }

  Future<String> getSecretKeyByClientId(String userName) async {
    String secretSubString = "Viet_Info";
    String secretKey = "$userName@$secretSubString";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(secretKey);
  }

  Future<Map<String, String>> getTokenFromServer() async {
    print("getTokenFromServer 2 2");
    String userName = AppSettings.getValue(KeyAppSetting.userName);
    String secretKey = await getSecretKeyByClientId(userName);

    var formData = FormData.fromMap({
      'grant_type': 'client_credentials',
      'client_id': userName,
      'client_secret': secretKey
    });

    var _url = '$BASE_URL/getToken';
    print(_url);
    print(userName);
    print(secretKey);
    var response = await Dio().post(_url, data: {
      'grant_type': 'client_credentials',
      'client_id': userName,
      'client_secret': secretKey
    });
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(response.statusCode);
    return response.data;
  }
}

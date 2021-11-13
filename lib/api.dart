import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:dio/adapter.dart';

class Api {
  late Dio _dio;

  String PEM = "XXXXX"; // certificate content
  String PKCS12File = "XXXXX"; // certificate content

  Future<Dio> getDio() async {
    var options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
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
    // String token = await FastData().getToken();
    String token = "";

    if (null != token && token.isNotEmpty) {
      headers["Authorization"] = token;
    }

    options.headers = headers;
    return super.onRequest(options, handler);
  }
}

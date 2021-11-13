

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit_and_chopper/constant.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl: "$BASE_URL/ThongKeDashboard")
abstract class ApiService{

  factory ApiService(Dio dio) => _ApiService(dio);



  @POST("/VanBan-ChiDao-GiaoViec")
  Future<LoginBean> getLogin({@Field('clientId') String clientId,@Field('clientSecret') String clientSecret,
    @Field('username') String username,@Field('password') String password});


}
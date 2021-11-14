import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit_and_chopper/constant.dart';
import 'package:retrofit_and_chopper/models/thong_ke_van_ban_den.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "$BASE_URL/ThongKeDashboard")
abstract class ApiService {
  factory ApiService(Dio dio) => _ApiService(dio);

  @POST("/GetThongKeVanBanDenDashboard")
  Future<ThongKeVanBanDenResult> getThongKeVanBanDen(
      @Field() String loaiTKGiaoViec,
      @Field() int userID,
      @Field() String userName,
      @Field() int phongBanID,
      @Field() int loaiChuyenVien);
}

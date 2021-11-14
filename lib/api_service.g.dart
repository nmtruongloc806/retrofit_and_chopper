// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??=
        'http://demo.vietinfo.tech/API_Dashboard_TPTHUDUC/ServiceAPI/ThongKeDashboard';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ThongKeVanBanDenResult> getThongKeVanBanDen(
      loaiTKGiaoViec, userID, userName, phongBanID, loaiChuyenVien) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'loaiTKGiaoViec': loaiTKGiaoViec,
      'userID': userID,
      'userName': userName,
      'phongBanID': phongBanID,
      'loaiChuyenVien': loaiChuyenVien
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ThongKeVanBanDenResult>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/GetThongKeVanBanDenDashboard',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ThongKeVanBanDenResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

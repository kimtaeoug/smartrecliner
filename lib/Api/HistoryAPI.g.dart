// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryAPI.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _HistoryAPI implements HistoryAPI {
  _HistoryAPI(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://183.99.48.93:8080/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<HistoryApiResponse>> getHistory(start, end, filterType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'end': end,
      r'filterType': filterType
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<HistoryApiResponse>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/api/history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            HistoryApiResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<HistoryApiResponse> getRecent() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HistoryApiResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/api/recent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HistoryApiResponse.fromJson(_result.data!);
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

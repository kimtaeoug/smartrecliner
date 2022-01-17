// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HApi.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _HApi implements HApi {
  _HApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://183.99.48.93:3310/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResultDto> insertHistoryData(insertDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(insertDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResultDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'historyInsert',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResultDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HApiInfoDto> requestHistoryRecent(onlyUserEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(onlyUserEmailDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HApiInfoDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'historyRecent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HApiInfoDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HApiInfoDto> requestHistoryDay(userEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userEmailDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HApiInfoDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'historyDay',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HApiInfoDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HApiInfoDto> requestHistoryWeek(userEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userEmailDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HApiInfoDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'historyWeek',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HApiInfoDto.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HApiInfoDto> requestHistoryMonth(userEmailDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userEmailDto.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HApiInfoDto>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'historyMonth',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HApiInfoDto.fromJson(_result.data!);
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

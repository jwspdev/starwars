// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_people_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RemotePeopleApiService implements RemotePeopleApiService {
  _RemotePeopleApiService(this._dio) {
    baseUrl ??= 'https://swapi.py4e.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<ListPeopleResponse>> listPeople(int pageNumber) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': pageNumber};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<ListPeopleResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'people/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ListPeopleResponse.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<Person>> getCurrentPerson(int id) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<Person>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'people/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Person.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
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

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

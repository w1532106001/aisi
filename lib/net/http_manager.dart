import 'dart:io';

import 'package:dio/dio.dart';

import 'address.dart';
import 'dio_log_interceptor.dart';
import 'response_interceptor.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(
          new BaseOptions(baseUrl: Address.baseUrl, connectTimeout: 15000));
      _dio.interceptors.add(new DioLogInterceptor());
//      _dio.interceptors.add(new PrettyDioLogger());
      _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Address.baseUrl) {
        _dio.options.baseUrl = Address.baseUrl;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, params) async {
    Response response;
    response = await _dio.get(api, queryParameters: params);
    return response.data;
  }

  ///通用的POST请求
  post(api, params) async {
    Response response;
    response = await _dio.post(api, queryParameters: params);
    return response.data;
  }

  download(api, params,path, {ProgressCallback onReceiveProgress}) async {
    try {
      Response response = await _dio.get(
        api,
        onReceiveProgress: onReceiveProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,),
      );
      print('123');
      File file = File(path);
      var raf = await file.open(mode: FileMode.write);
      // response.data is List<int> type
      await raf.writeFrom(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
    print('下载完成');
  }
}

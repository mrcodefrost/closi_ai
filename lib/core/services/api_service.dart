// import 'dart:convert';
//
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
//
// import '../core/services/api_endpoints.dart';
// import 'Auth_Api/TokenReferesh/controller/token_refresh_controller.dart';
//
// class ApiService extends GetxService {
//   static const String baseUrl = ApiEndpoints.baseUrl;
//   late dio.Dio _dio;
//   final Logger _logger = Logger();
//   final CookieJar _cookieJar = CookieJar();
//   late final TokenRefreshController _refreshController;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _refreshController = TokenRefreshController(this);
//     _initializeDio();
//   }
//
//   void _initializeDio() {
//     final options = dio.BaseOptions(
//       baseUrl: baseUrl,
//       connectTimeout: const Duration(seconds: 20),
//       receiveTimeout: const Duration(seconds: 20),
//       contentType: 'application/json',
//       validateStatus: (status) =>
//           status != null && status >= 200 && status < 500,
//     );
//
//     _dio = dio.Dio(options);
//     _dio.interceptors.add(CookieManager(_cookieJar));
//
//     _dio.interceptors.addAll([
//       _AuthInterceptor(_logger),
//       _LoggingInterceptor(_logger),
//       _TokenRefreshInterceptor(this, _refreshController),
//     ]);
//   }
//
//   Future<dynamic> get(
//     String endpoint, {
//     Map<String, dynamic>? queryParams,
//   }) async {
//     try {
//       final accessToken = PreferenceManager.getString(
//         PreferenceManager.accessToken,
//       );
//
//       final response = await _dio.get(
//         endpoint,
//         queryParameters: queryParams,
//         options: dio.Options(
//           headers: {
//             if (accessToken != null) 'Authorization': 'Bearer $accessToken',
//           },
//         ),
//       );
//
//       return _processResponse(response);
//     } on dio.DioException catch (e) {
//       if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
//         final refreshSuccess = await _refreshController.refreshToken();
//
//         if (refreshSuccess == true) {
//           final newToken = PreferenceManager.getString(
//             PreferenceManager.accessToken,
//           );
//           final retryResponse = await _dio.get(
//             endpoint,
//             queryParameters: queryParams,
//             options: dio.Options(
//               headers: {
//                 if (newToken != null) 'Authorization': 'Bearer $newToken',
//               },
//             ),
//           );
//           return _processResponse(retryResponse);
//         } else {
//           PreferenceManager.clearAuthData();
//           Get.offAllNamed(Routes.REGISTER);
//           throw Exception('Session expired. Please log in again.');
//         }
//       } else {
//         _handleDioError(e);
//       }
//     }
//   }
//
//   Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
//     try {
//       final response = await _dio.post(endpoint, data: data);
//       return _processResponse(response);
//     } on dio.DioException catch (e) {
//       _handleDioError(e);
//     }
//   }
//
//   Future<dynamic> put(String endpoint, {Map<String, dynamic>? data}) async {
//     try {
//       final response = await _dio.put(endpoint, data: data);
//       return _processResponse(response);
//     } on dio.DioException catch (e) {
//       _handleDioError(e);
//     }
//   }
//
//   Future<dynamic> delete(String endpoint, {Map<String, dynamic>? data}) async {
//     try {
//       final response = await _dio.delete(endpoint, data: data);
//       return _processResponse(response);
//     } on dio.DioException catch (e) {
//       _handleDioError(e);
//     }
//   }
//
//   // Uploading a single file only
//   Future<dynamic> uploadFile({
//     required String endpoint,
//     required String filePath,
//     String? fileField = 'file',
//   }) async {
//     try {
//       final fileName = filePath.split('/').last;
//       final formData = dio.FormData.fromMap({
//         fileField!: await dio.MultipartFile.fromFile(
//           filePath,
//           filename: fileName,
//         ),
//       });
//
//       final response = await _dio.post(endpoint, data: formData);
//       return _processResponse(response);
//     } on dio.DioException catch (e) {
//       _handleDioError(e);
//     }
//   }
//
//   // Uploading multiple files
//
//   Future<dynamic> postFormData({
//     required String endpoint,
//     required Map<String, dynamic> fields,
//     required List<String> filePaths,
//     String fileField = 'files',
//     String? customBaseUrl,
//     String? xApiKey, // <-- dynamic API key
//   }) async {
//     try {
//       final formData = dio.FormData();
//
//       // Add fields
//       fields.forEach((key, value) {
//         if (value is Map || value is List) {
//           formData.fields.add(MapEntry(key, jsonEncode(value)));
//         } else {
//           formData.fields.add(MapEntry(key, value.toString()));
//         }
//       });
//
//       // Add files
//       for (var path in filePaths) {
//         final fileName = path.split('/').last;
//         formData.files.add(
//           MapEntry(
//             fileField,
//             await dio.MultipartFile.fromFile(path, filename: fileName),
//           ),
//         );
//       }
//
//       final accessToken = PreferenceManager.getString(
//         PreferenceManager.accessToken,
//       );
//
//       // Construct headers dynamically
//       final headers = <String, String>{
//         if (accessToken != null) 'Authorization': 'Bearer $accessToken',
//         if (xApiKey != null) 'x-api-key': xApiKey,
//       };
//
//       final response = await _dio.post(
//         '${customBaseUrl ?? baseUrl}$endpoint',
//         data: formData,
//         options: dio.Options(headers: headers),
//       );
//
//       return _processResponse(response);
//     } on dio.DioException catch (e) {
//       _handleDioError(e);
//     }
//   }
//
//   dynamic _processResponse(dio.Response response) {
//     if (response.statusCode != null &&
//         response.statusCode! >= 200 &&
//         response.statusCode! < 300) {
//       return response.data;
//     } else {
//       final message = response.data['message'] ?? 'Something went wrong';
//       throw ApiException(statusCode: response.statusCode!, message: message);
//     }
//   }
//
//   void updateAuthorizationHeader(String token) {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }
//
//   void _handleDioError(dio.DioException e) {
//     if (e.response != null) {
//       final message = e.response?.data['message'] ?? e.message;
//       _logger.e('Error occurred: $message');
//       throw ApiException(
//         statusCode: e.response?.statusCode ?? 500,
//         message: message,
//       );
//     } else {
//       _logger.e('Dio error: ${e.message}');
//       throw ApiException(
//         statusCode: 500,
//         message: e.message ?? 'Unknown error',
//       );
//     }
//   }
// }
//
// class _AuthInterceptor extends dio.Interceptor {
//   final Logger _logger;
//   _AuthInterceptor(this._logger);
//
//   @override
//   void onRequest(
//     dio.RequestOptions options,
//     dio.RequestInterceptorHandler handler,
//   ) {
//     final token = PreferenceManager.getString(PreferenceManager.accessToken);
//     _logger.i('Using token: $token');
//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }
// }
//
// class _LoggingInterceptor extends dio.Interceptor {
//   final Logger _logger;
//   _LoggingInterceptor(this._logger);
//
//   @override
//   void onRequest(
//     dio.RequestOptions options,
//     dio.RequestInterceptorHandler handler,
//   ) {
//     _logger.i('➡️ [${options.method}] ${options.uri}');
//
//     if (options.headers.isNotEmpty) {
//       _logger.i('Headers: ${options.headers}');
//     }
//
//     if (options.queryParameters.isNotEmpty) {
//       _logger.i('Query Parameters: ${options.queryParameters}');
//     }
//
//     if (options.data != null) {
//       if (options.data is dio.FormData) {
//         final formDataMap = <String, dynamic>{};
//
//         // Log fields
//         (options.data as dio.FormData).fields.forEach((field) {
//           formDataMap[field.key] = field.value;
//         });
//
//         // Log files (only file names for brevity)
//         (options.data as dio.FormData).files.forEach((file) {
//           formDataMap[file.key] = 'FILE: ${file.value.filename}';
//         });
//
//         _logger.i('Request Body (FormData):\n${_prettyPrintJson(formDataMap)}');
//       } else {
//         _logger.i('Request Body:\n${_prettyPrintJson(options.data)}');
//       }
//     }
//
//     handler.next(options);
//   }
//
//   @override
//   void onResponse(
//     dio.Response response,
//     dio.ResponseInterceptorHandler handler,
//   ) {
//     _logger.i('✅ [${response.statusCode}] ${response.requestOptions.uri}');
//     _logger.i('Response Body: ${response.data}');
//     handler.next(response);
//   }
//
//   @override
//   void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
//     _logger.e('❌ [${err.response?.statusCode}] ${err.requestOptions.uri}');
//     _logger.e('Error: ${err.message}');
//     if (err.response != null) {
//       _logger.e('Error Body: ${err.response?.data}');
//     }
//     handler.next(err);
//   }
// }
//
// String _prettyPrintJson(dynamic jsonObject) {
//   try {
//     final encoder = JsonEncoder.withIndent('  ');
//     return encoder.convert(jsonObject);
//   } catch (e) {
//     return jsonObject.toString(); // Fallback for non-JSON data
//   }
// }
//
// class _TokenRefreshInterceptor extends dio.Interceptor {
//   final ApiService _apiService;
//   final TokenRefreshController _refreshController;
//   bool _isRefreshing = false;
//
//   _TokenRefreshInterceptor(this._apiService, this._refreshController);
//
//   @override
//   Future<void> onError(
//     dio.DioException err,
//     dio.ErrorInterceptorHandler handler,
//   ) async {
//     if (_shouldRefreshToken(err)) {
//       if (_isRefreshing) {
//         await Future.delayed(Duration(milliseconds: 300));
//       }
//
//       _isRefreshing = true;
//
//       try {
//         final tokenResponse = await _refreshController.refreshToken();
//         if (tokenResponse.status == 'success' && tokenResponse.data != null) {
//           final newAccessToken = tokenResponse.data!.accessToken;
//           _apiService.updateAuthorizationHeader(newAccessToken);
//
//           final requestOptions = err.requestOptions;
//           requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
//
//           final retryResponse = await _apiService._dio.fetch(requestOptions);
//           _isRefreshing = false;
//           return handler.resolve(retryResponse);
//         } else {
//           _isRefreshing = false;
//           return handler.reject(err);
//         }
//       } catch (e) {
//         _isRefreshing = false;
//         return handler.reject(err);
//       }
//     }
//
//     return handler.next(err);
//   }
//
//   bool _shouldRefreshToken(dio.DioException err) {
//     return (err.response?.statusCode == 401 ||
//             err.response?.statusCode == 403) &&
//         err.requestOptions.path != ApiEndpoints.refreshToken &&
//         PreferenceManager.getString(PreferenceManager.refreshToken) != null;
//   }
// }
//
// class ApiException implements Exception {
//   final int statusCode;
//   final String message;
//   ApiException({required this.statusCode, required this.message});
//
//   @override
//   String toString() => 'ApiException $statusCode: $message';
// }

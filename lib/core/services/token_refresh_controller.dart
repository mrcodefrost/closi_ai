// class TokenRefreshController {
//   final ApiService _apiService;
//
//   TokenRefreshController(this._apiService);
//
//   Future<TokenRefreshResponse> refreshToken() async {
//     final currentAccessToken = PreferenceManager.getString(
//       PreferenceManager.accessToken,
//     );
//
//     if (currentAccessToken == null || currentAccessToken.isEmpty) {
//       return TokenRefreshResponse(
//         status: 'error',
//         message: 'No access token found in storage',
//         data: null,
//       );
//     }
//
//     try {
//       final response = await dio.Dio().post(
//         ApiEndpoints.baseUrl + ApiEndpoints.refreshToken,
//         options: dio.Options(
//           headers: {
//             'Authorization': 'Bearer $currentAccessToken',
//             'Content-Type': 'application/json',
//           },
//           validateStatus: (status) => status != null && status < 500,
//         ),
//         data: {}, // Can be empty or contain device/session info
//       );
//
//       if (response.statusCode == 200 &&
//           response.data is Map<String, dynamic> &&
//           response.data['status'] == 'success') {
//         final tokenResponse = TokenRefreshResponse.fromJson(response.data);
//
//         if (tokenResponse.data != null &&
//             tokenResponse.data!.accessToken.isNotEmpty) {
//           PreferenceManager.setData(
//             PreferenceManager.accessToken,
//             tokenResponse.data!.accessToken,
//           );
//           PreferenceManager.setData(
//             PreferenceManager.refreshToken,
//             tokenResponse.data!.refreshToken,
//           );
//
//           _apiService.updateAuthorizationHeader(
//             tokenResponse.data!.accessToken,
//           );
//         }
//
//         return tokenResponse;
//       } else {
//         return TokenRefreshResponse(
//           status: 'error',
//           message: response.data?['message'] ?? 'Failed to refresh token',
//           data: null,
//         );
//       }
//     } catch (e) {
//       return TokenRefreshResponse(
//         status: 'error',
//         message: 'Exception: ${e.toString()}',
//         data: null,
//       );
//     }
//   }
// }
//
// class TokenAutoRefreshController extends GetxController {
//   late final Timer _refreshTimer;
//   final TokenRefreshController _refreshController;
//   final Logger _logger = Logger();
//
//   TokenAutoRefreshController(this._refreshController);
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     // Start refresh every 14 minutes
//     _refreshTimer = Timer.periodic(Duration(minutes: 14), (_) async {
//       _logger.i('🔄 Triggering scheduled token refresh');
//       final response = await _refreshController.refreshToken();
//
//       if (response.status == 'success') {
//         _logger.i('✅ Token refreshed successfully');
//       } else {
//         _logger.e('❌ Token refresh failed: ${response.message}');
//         // Optional: logout or handle expired session
//       }
//     });
//   }
//
//   @override
//   void onClose() {
//     _refreshTimer.cancel();
//     _logger.w('🛑 Token auto-refresh stopped');
//     super.onClose();
//   }
// }

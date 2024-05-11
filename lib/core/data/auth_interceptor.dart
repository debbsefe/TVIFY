import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:tvify/core/config.dart';
import 'package:tvify/core/utils/strings.dart';

Provider<Client> httpClientProvider = Provider<Client>((ref) {
  final config = ref.watch(configProvider);
  return InterceptedClient.build(
    interceptors: [
      AuthInterceptor(config: config),
    ],
  );
});

class AuthInterceptor implements InterceptorContract {
  AuthInterceptor({required this.config});

  final Config config;
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final String token = await config.fetchToken(Strings.apiKeyTmdb);

    final Uri modifiedUrl = request.url.replace(
      queryParameters: <String, String>{
        ...request.url.queryParameters,
        'api_key': token,
      },
    );
    return request.copyWith(url: modifiedUrl);
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    return response;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return false;
  }
}

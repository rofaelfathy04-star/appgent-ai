import 'package:dio/dio.dart';
import 'constants.dart';

class AiService {
  final Dio _dio = Dio();

  Future<String> generateAppCode(String idea) async {
    final response = await _dio.post(
      AppConstants.openAiEndpoint,
      options: Options(headers: {
        'Authorization': 'Bearer ${AppConstants.openAiApiKey}',
        'Content-Type': 'application/json',
      }),
      data: {
        "model": "gpt-4o",
        "messages": [
          {"role": "system", "content": "أنت مبرمج Flutter محترف. رجع كود Flutter كامل شغال 100% بصيغة JSON: {\"files\":[{\"path\":\"...\",\"content\":\"...\"}]}. الواجهة عربية RTL."},
          {"role": "user", "content": "ابني لي تطبيق لهذه الفكرة: $idea"}
        ],
        "temperature": 0.7,
        "max_tokens": 4000
      },
    );
    String content = response.data['choices'][0]['message']['content'];
    return content.replaceAll('```json', '').replaceAll('```', '').trim();
  }
}
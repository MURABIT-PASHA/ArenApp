import 'package:dio/dio.dart';
class OpenAI{
  final String _apiKey = "YOUR_API_KEY_HERE";
  final String _model = "text-davinci-003";
  final String prompt;
  final int _maxTokens = 100;
  final List<String> _stop = ["\n"];
  OpenAI({required this.prompt});

  Future getResponse() async {
    Response response = await Dio().post(
      "https://api.openai.com/v1/completions",
      options: Options(headers: {"Authorization": "Bearer $_apiKey"}),
      data: {
        "model": _model,
        "prompt": prompt,
        "max_tokens": _maxTokens,
        "stop": _stop,
      },
    );
    return response.data;
  }
}


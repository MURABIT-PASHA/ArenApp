import 'package:dio/dio.dart';
class OpenAI{
  final String _apiKey = "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";
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
        "temperature": 0.9,
        "max_tokens": 150,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.6,
        "stop": [" Human:", " AI:"],
      },
    );
    return response.data;
  }
}
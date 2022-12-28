class Conversation {
  final String prompt;
  final int number;
  final DateTime date;

  Conversation({required this.prompt, required this.number, required this.date});
  Map<String, dynamic> toMap() {
    return {
      'prompt': prompt,
      'number': number,
      'date': date.toIso8601String(),
    };
  }
  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      prompt: map['prompt'],
      number: map['number'],
      date: map['date'],
    );
  }
}
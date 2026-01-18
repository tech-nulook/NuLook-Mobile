
class AnswerRequestModel {
  final List<AnswerItem> answers;

  AnswerRequestModel({required this.answers});

  Map<String, dynamic> toJson() {
    return {
      "answers": answers.map((e) => e.toJson()).toList(),
    };
  }
}

class AnswerItem {
  final int questionId;
  final int optionId;

  AnswerItem({
    required this.questionId,
    required this.optionId,
  });

  Map<String, dynamic> toJson() {
    return {
      "question_id": questionId,
      "option_id": optionId,
    };
  }
}
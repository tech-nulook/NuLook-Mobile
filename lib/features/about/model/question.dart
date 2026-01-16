class Question {
  int? id;
  String? text;
  bool? isActive;
  List<Options>? options;

  Question({this.id, this.text, this.isActive, this.options});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    isActive = json['is_active'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['is_active'] = this.isActive;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  int? questionId;
  String? text;

  Options({this.id, this.questionId, this.text});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['text'] = this.text;
    return data;
  }
}
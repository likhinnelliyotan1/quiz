class Answers {
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  String? answerE;
  String? answerF;

  Answers(
      {this.answerA,
        this.answerB,
        this.answerC,
        this.answerD,
        this.answerE,
        this.answerF});

  Answers.fromJson(Map<String, dynamic> json) {
    answerA = json['answer_a'];
    answerB = json['answer_b'];
    answerC = json['answer_c'];
    answerD = json['answer_d'];
    answerE = json['answer_e'];
    answerF = json['answer_f'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_a'] = this.answerA;
    data['answer_b'] = this.answerB;
    data['answer_c'] = this.answerC;
    data['answer_d'] = this.answerD;
    data['answer_e'] = this.answerE;
    data['answer_f'] = this.answerF;
    return data;
  }
}
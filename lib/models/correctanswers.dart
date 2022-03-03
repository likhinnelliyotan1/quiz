class CorrectAnswers {
  String? answerACorrect;
  String? answerBCorrect;
  String? answerCCorrect;
  String? answerDCorrect;
  String? answerECorrect;
  String? answerFCorrect;

  CorrectAnswers(
      {this.answerACorrect,
        this.answerBCorrect,
        this.answerCCorrect,
        this.answerDCorrect,
        this.answerECorrect,
        this.answerFCorrect});

  CorrectAnswers.fromJson(Map<String, dynamic> json) {
    answerACorrect = json['answer_a_correct'];
    answerBCorrect = json['answer_b_correct'];
    answerCCorrect = json['answer_c_correct'];
    answerDCorrect = json['answer_d_correct'];
    answerECorrect = json['answer_e_correct'];
    answerFCorrect = json['answer_f_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_a_correct'] = this.answerACorrect;
    data['answer_b_correct'] = this.answerBCorrect;
    data['answer_c_correct'] = this.answerCCorrect;
    data['answer_d_correct'] = this.answerDCorrect;
    data['answer_e_correct'] = this.answerECorrect;
    data['answer_f_correct'] = this.answerFCorrect;
    return data;
  }
}
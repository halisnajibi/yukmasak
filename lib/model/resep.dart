// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResepModel {
  String title;
  String thumb;
  String times;
  String difficulty;
  String? key;
  String? colories;
  String? desc;
  List<String>? ingredient;
  List<String>? step;
  ResepModel(
      {required this.title,
      required this.thumb,
      required this.times,
      required this.difficulty,
      this.key,
      this.colories,
      this.desc,
      this.ingredient,
      this.step});

  factory ResepModel.fromJson(Map<String, dynamic> json) {
    return ResepModel(
      title: json['title'],
      thumb: json['thumb'],
      times: json['times'],
      difficulty: json['difficulty'],
      key: json.containsKey('key') ? json['key'] : null,
      colories: json.containsKey('calories') ? json['calories'] : null,
      desc: json.containsKey('desc') ? json['desc'] : null,
      ingredient: json.containsKey('ingredient')
          ? List<String>.from(json['ingredient'])
          : [],
      step: json.containsKey('step') ? List<String>.from(json['step']) : [],
    );
  }

  @override
  String toString() {
    return 'ResepModel(title: $title, thumb: $thumb, times: $times, difficulty: $difficulty, key: $key, colories: $colories, desc: $desc, ingredient: $ingredient, step: $step)';
  }
}

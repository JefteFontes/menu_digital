class Comment {
  final String id;
  final String userName;
  final String text;
  final String? imageUrl;
  final DateTime date;
  final String? idRestaurant;

  Comment({
    required this.id,
    required this.userName,
    required this.text,
    this.imageUrl,
    required this.date,
    this.idRestaurant,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'text': text,
      'imageUrl': imageUrl,
      'date': date.toIso8601String(),
      'idRestaurant': idRestaurant
    };
  }

  factory Comment.fromJson(String id, Map<String, dynamic> json) {
    return Comment(
      id: id,
      userName: json['userName'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      date: DateTime.parse(json['date']),
      idRestaurant: json['idRestaurant'],
    );
  }
}
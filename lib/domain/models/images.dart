class Imagens {
  final String image;

  Imagens({
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "foto": image,
      };

  factory Imagens.fromJson(Map<String, dynamic> json) {
    return Imagens(
      image: json['foto'],
    );
  }
}

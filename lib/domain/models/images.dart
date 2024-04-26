class Imagens {
  final String image;

Imagens({
    required this.image,
  });


Map<String, dynamic> toJson() => {
        "foto": image,
      };

}
class Lirik {
  late String? judul;
  late String? lirik;
  late String? karya;

  Lirik({this.judul, this.lirik, this.karya});

  factory Lirik.fromJson(dynamic json) {
    return Lirik(
      judul: "${json['judul']}",
      lirik: "${json['lirik']}",
      karya: "${json['karya']}",
    );
  }
  Map toJson() => {
        "judul": judul,
        "lirik": lirik,
        "karya": karya,
      };
}

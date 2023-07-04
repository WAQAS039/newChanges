class Names {
  int? id;
  String? arabictext;
  String? audioUrl;
  String? english;
  String? urduMeaning;
  String? englishMeaning;
  String? arabicMeaning;
  String? indonesianmeaning;
  String? hindiMeaning;
  String? bengalimeaning;
  String? frenchmeaning;
  String? chinesemeaning;
  String? somalimeaning;
  String? germanmeaning;
  String? spanishmeaning;

  Names(
      {this.id,
        this.arabictext,
        this.audioUrl,
        this.english,
        this.urduMeaning,
        this.englishMeaning,
        this.arabicMeaning,
        this.indonesianmeaning,
        this.hindiMeaning,
        this.bengalimeaning,
        this.frenchmeaning,
        this.chinesemeaning,
        this.somalimeaning,
        this.germanmeaning,
        this.spanishmeaning});

  Names.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabictext = json['arabictext'];
    audioUrl = json['audio_url'];
    english = json['english'];
    urduMeaning = json['urduMeaning'];
    englishMeaning = json['englishMeaning'];
    arabicMeaning = json['arabicMeaning'];
    indonesianmeaning = json['Indonesianmeaning'];
    hindiMeaning = json['hindiMeaning'];
    bengalimeaning = json['bengalimeaning'];
    frenchmeaning = json['frenchmeaning'];
    chinesemeaning = json['chinesemeaning'];
    somalimeaning = json['somalimeaning'];
    germanmeaning = json['germanmeaning'];
    spanishmeaning = json['spanishmeaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arabictext'] = this.arabictext;
    data['audio_url'] = this.audioUrl;
    data['english'] = this.english;
    data['urduMeaning'] = this.urduMeaning;
    data['englishMeaning'] = this.englishMeaning;
    data['arabicMeaning'] = this.arabicMeaning;
    data['Indonesianmeaning'] = this.indonesianmeaning;
    data['hindiMeaning'] = this.hindiMeaning;
    data['bengalimeaning'] = this.bengalimeaning;
    data['frenchmeaning'] = this.frenchmeaning;
    data['chinesemeaning'] = this.chinesemeaning;
    data['somalimeaning'] = this.somalimeaning;
    data['germanmeaning'] = this.germanmeaning;
    data['spanishmeaning'] = this.spanishmeaning;
    return data;
  }
}

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  final String? regionCode;

  Language(this.id, this.flag, this.name, this.languageCode, {this.regionCode});

  @override
  String toString() {
    return "$flag $name $languageCode${this.regionCode != null ? '_${this.regionCode?.toUpperCase()}' : ''}";
  }
}

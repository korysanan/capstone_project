enum Language {
  bg(language: "Bulgarian", flag: '🇧🇬'),
  da(language: "Danish", flag: '🇩🇰'),
  de(language: "German", flag: '🇩🇪'),
  el(language: "Greek", flag: '🇬🇷'),
  en(language: "English", locale: "en_US", flag: '🇬🇧'),
  es(language: "Spanish", flag: '🇪🇸'),
  et(language: "Estonian", flag: '🇪🇪'),
  fi(language: "Finnish", flag: '🇫🇮'),
  fr(language: "French", flag: '🇫🇷'),
  hu(language: "Hungarian", flag: '🇭🇺'),
  id(language: "Indonesian", flag: '🇮🇩'),
  it(language: "Italian", flag: '🇮🇹'),
  ja(language: "Japanese", flag: '🇯🇵'),
  ko(language: "Korean", flag: '🇰🇷'),
  lt(language: "Lithuanian", flag: '🇱🇹'),
  lv(language: "Latvian", flag: '🇱🇻'),
  nb(language: "Norwegian Bokmal", flag: '🇳🇴'),
  nl(language: "Dutch", flag: '🇳🇱'),
  pl(language: "Polish", flag: '🇵🇱'),
  pt(language: "Portuguese", locale: "pt-PT", flag: '🇵🇹'),
  ro(language: "Romanian", flag: '🇷🇴'),
  sk(language: "Slovak", flag: '🇸🇰'),
  sl(language: "Slovenian", flag: '🇸🇮'),
  sv(language: "Swedish", flag: '🇸🇪'),
  tr(language: "Turkish", flag: '🇹🇷'),
  uk(language: "Ukrainian", flag: '🇺🇦'),
  zh(language: "Chinese", flag: '🇨🇳');

  final String language;
  final String? locale;
  final String flag;

  const Language({
    required this.language,
    this.locale,
    required this.flag,
  });
}

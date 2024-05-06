enum Language {
  ko(language: "한국어"),
  el(language: "Ελληνική"),
  nl(language: "Nederlands"),
  no(language: "Norge"),
  da(language: "Dansk"),
  de(language: "Deutsch"),
  lv(language: "Latviešu"),
  ru(language: "Русский"),
  ro(language: "Românesc"),
  lt(language: "Lietuvių kalba"),
  bg(language: "Български"),
  sv(language: "Svenska"),
  es(language: "Español"),
  sk(language: "Slovensko"),
  sl(language: "Slovenski"),
  ar(language: "اللغة العربية"),
  et(language: "Eesti"),
  en(language: "English (USA)", locale: "en-US"),
  eu(language: "English (UK)", locale: "en-GB"), // 일단 이렇게만
  uk(language: "Українська"),
  it(language: "Italiano"),
  id(language: "Bahasa Indonesia"),
  ja(language: "日本語"),
  zh(language: "中文"),
  cs(language: "Česky"),
  tr(language: "Türkçe"),
  pt(language: "Português", locale: "pt-PT"),
  br(language: "Português (Brasil)", locale: "pt-BR"), // 일단 이렇게만
  pl(language: "Polski"),
  fr(language: "Français"),
  fi(language: "Suomalainen"),
  hu(language: "Magyar");

  const Language({
    required this.language,
    this.locale,
  });

  final String language;
  final String? locale;
}

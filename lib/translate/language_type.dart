enum Language {
  ko,
  el,
  nl,
  no,
  da,
  de,
  lv,
  ru,
  ro,
  lt,
  bg,
  sv,
  es,
  sk,
  sl,
  ar,
  et,
  en,
  eu,
  uk,
  it,
  id,
  ja,
  zh,
  cs,
  tr,
  pt,
  br,
  pl,
  fr,
  fi,
  hu;

  int get lang_id {
    switch (this) {
      case Language.ko: return 1;
      case Language.el: return 2;
      case Language.nl: return 3;
      case Language.no: return 4;
      case Language.da: return 5;
      case Language.de: return 6;
      case Language.lv: return 7;
      case Language.ru: return 8;
      case Language.ro: return 9;
      case Language.lt: return 10;
      case Language.bg: return 11;
      case Language.sv: return 12;
      case Language.es: return 13;
      case Language.sk: return 14;
      case Language.sl: return 15;
      case Language.ar: return 16;
      case Language.et: return 17;
      case Language.en: return 18;
      case Language.eu: return 19;
      case Language.uk: return 20;
      case Language.it: return 21;
      case Language.id: return 22;
      case Language.ja: return 23;
      case Language.zh: return 24;
      case Language.cs: return 25;
      case Language.tr: return 26;
      case Language.pt: return 27;
      case Language.br: return 28;
      case Language.pl: return 29;
      case Language.fr: return 30;
      case Language.fi: return 31;
      case Language.hu: return 32;
      default: return 0; // 기본값 처리
    }
  }

  String getDisplayName() {
    switch (this) {
      case Language.ko:
        return "한국어";
      case Language.el:
        return "Ελληνική";
      case Language.nl:
        return "Nederlands";
      case Language.no:
        return "Norge";
      case Language.da:
        return "Dansk";
      case Language.de:
        return "Deutsch";
      case Language.lv:
        return "Latviešu";
      case Language.ru:
        return "Русский";
      case Language.ro:
        return "Românesc";
      case Language.lt:
        return "Lietuvių kalba";
      case Language.bg:
        return "Български";
      case Language.sv:
        return "Svenska";
      case Language.es:
        return "Español";
      case Language.sk:
        return "Slovensko";
      case Language.sl:
        return "Slovenski";
      case Language.ar:
        return "اللغة العربية";
      case Language.et:
        return "Eesti";
      case Language.en:
        return "English (USA)";
      case Language.eu:
        return "English (UK)";
      case Language.uk:
        return "Українська";
      case Language.it:
        return "Italiano";
      case Language.id:
        return "Bahasa Indonesia";
      case Language.ja:
        return "日本語";
      case Language.zh:
        return "中文";
      case Language.cs:
        return "Česky";
      case Language.tr:
        return "Türkçe";
      case Language.pt:
        return "Português";
      case Language.br:
        return "Português (Brasil)";
      case Language.pl:
        return "Polski";
      case Language.fr:
        return "Français";
      case Language.fi:
        return "Suomalainen";
      case Language.hu:
        return "Magyar";
      default:
        return "Unknown";
    }
  }

  String? get locale {
    switch (this) {
      case Language.en:
        return "en-US";
      case Language.eu:
        return "en-GB";
      case Language.pt:
        return "pt-PT";
      case Language.br:
        return "pt-BR";
      default:
        return null;
    }
  }
}

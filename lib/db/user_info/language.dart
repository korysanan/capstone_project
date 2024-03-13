enum LanguageType {
  bg, da, de, el, en, es, et, fi, fr, hu, id, it, ja, ko,
  lt, lv, nb, nl, pl, pt, ro, sk, sl, sv, tr, uk, zh,
}

extension LanguageTypeExtension on LanguageType {
  String get language {
    switch (this) {
      case LanguageType.bg:
        return "Bulgarian";
      case LanguageType.da:
        return "Danish";
      case LanguageType.de:
        return "German";
      case LanguageType.el:
        return "Greek";
      case LanguageType.en:
        return "English";
      case LanguageType.es:
        return "Spanish";
      case LanguageType.et:
        return "Estonian";
      case LanguageType.fi:
        return "Finnish";
      case LanguageType.fr:
        return "French";
      case LanguageType.hu:
        return "Hungarian";
      case LanguageType.id:
        return "Indonesian";
      case LanguageType.it:
        return "Italian";
      case LanguageType.ja:
        return "Japanese";
      case LanguageType.ko:
        return "Korean";
      case LanguageType.lt:
        return "Lithuanian";
      case LanguageType.lv:
        return "Latvian";
      case LanguageType.nb:
        return "Norwegian Bokmal";
      case LanguageType.nl:
        return "Dutch";
      case LanguageType.pl:
        return "Polish";
      case LanguageType.pt:
        return "Portuguese";
      case LanguageType.ro:
        return "Romanian";
      case LanguageType.sk:
        return "Slovak";
      case LanguageType.sl:
        return "Slovenian";
      case LanguageType.sv:
        return "Swedish";
      case LanguageType.tr:
        return "Turkish";
      case LanguageType.uk:
        return "Ukrainian";
      case LanguageType.zh:
        return "Chinese";
      default:
        return "Unknown";
    }
  }

  String get flag {
    switch (this) {
      case LanguageType.bg:
        return '🇧🇬';
      case LanguageType.da:
        return '🇩🇰';
      case LanguageType.de:
        return '🇩🇪';
      case LanguageType.el:
        return '🇬🇷';
      case LanguageType.en:
        return '🇬🇧';
      case LanguageType.es:
        return '🇪🇸';
      case LanguageType.et:
        return '🇪🇪';
      case LanguageType.fi:
        return '🇫🇮';
      case LanguageType.fr:
        return '🇫🇷';
      case LanguageType.hu:
        return '🇭🇺';
      case LanguageType.id:
        return '🇮🇩';
      case LanguageType.it:
        return '🇮🇹';
      case LanguageType.ja:
        return '🇯🇵';
      case LanguageType.ko:
        return '🇰🇷';
      case LanguageType.lt:
        return '🇱🇹';
      case LanguageType.lv:
        return '🇱🇻';
      case LanguageType.nb:
        return '🇳🇴';
      case LanguageType.nl:
        return '🇳🇱';
      case LanguageType.pl:
        return '🇵🇱';
      case LanguageType.pt:
        return '🇵🇹';
      case LanguageType.ro:
        return '🇷🇴';
      case LanguageType.sk:
        return '🇸🇰';
      case LanguageType.sl:
        return '🇸🇮';
      case LanguageType.sv:
        return '🇸🇪';
      case LanguageType.tr:
        return '🇹🇷';
      case LanguageType.uk:
        return '🇺🇦';
      case LanguageType.zh:
        return '🇨🇳';
      default:
        return '🏳️';
    }
  }

  String? get locale {
    switch (this) {
      case LanguageType.en:
        return "en_US";
      case LanguageType.pt:
        return "pt_PT";
      default:
        return null;
    }
  }
}
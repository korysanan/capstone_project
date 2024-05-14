class KoreanRegion {
  final int id;
  final String name;
  final String englishName;

  KoreanRegion({required this.id, required this.name, required this.englishName});

  static List<KoreanRegion> regions = [
    KoreanRegion(id: 1, name: '서울특별시', englishName: 'Seoul'),
    KoreanRegion(id: 2, name: '부산광역시', englishName: 'Busan Metropolitan City'),
    KoreanRegion(id: 3, name: '대구광역시', englishName: 'Daegu Metropolitan City'),
    KoreanRegion(id: 4, name: '인천광역시', englishName: 'Incheon Metropolitan City'),
    KoreanRegion(id: 5, name: '광주광역시', englishName: 'Gwangju Metropolitan City'),
    KoreanRegion(id: 6, name: '대전광역시', englishName: 'Daejeon Metropolitan City'),
    KoreanRegion(id: 7, name: '울산광역시', englishName: 'Ulsan Metropolitan City'),
    KoreanRegion(id: 8, name: '세종특별자치시', englishName: 'Sejong Special Self-Governing City'),
    KoreanRegion(id: 9, name: '경기도', englishName: 'Gyeonggi-do'),
    KoreanRegion(id: 10, name: '강원특별자치도', englishName: 'Gangwon Special Self-Governing Province'),
    KoreanRegion(id: 11, name: '충청북도', englishName: 'Chungcheongbuk-do'),
    KoreanRegion(id: 12, name: '충청남도', englishName: 'Chungcheongnam-do'),
    KoreanRegion(id: 13, name: '전북특별자치도', englishName: 'Jeonbuk Special Self-Governing Province'),
    KoreanRegion(id: 14, name: '전라남도', englishName: 'Jeollanam-do'),
    KoreanRegion(id: 15, name: '경상북도', englishName: 'Gyeongsangbuk-do'),
    KoreanRegion(id: 16, name: '경상남도', englishName: 'Gyeongsangnam-do'),
    KoreanRegion(id: 17, name: '제주특별자치도', englishName: 'Jeju Special Self-Governing Province'),
  ];
}

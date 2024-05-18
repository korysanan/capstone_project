class KoreanFood {
  final int id;
  final String name;
  final String englishName;
  final String imageUrl;

  KoreanFood(
      {required this.id,
      required this.name,
      required this.englishName,
      required this.imageUrl});

  static List<KoreanFood> foods = [
    KoreanFood(
        id: 1,
        name: '치킨',
        englishName: 'Chicken',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715400669718-05ee0218-06e1-462f-80fb-f5915ee23f62.jpg'),
    KoreanFood(
        id: 2,
        name: '생선구이',
        englishName: 'baked fish',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715404636134-0e4da5cc-ffea-4141-8d3e-a44369ea2615.jpg'),
    KoreanFood(
        id: 3,
        name: '과메기',
        englishName: 'Half-dried Saury',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715400457689-30e34658-23bf-4a12-8e3b-8e15574af6d0.jpg'),
    KoreanFood(
        id: 4,
        name: '갈비구이',
        englishName: 'Grilled ribs',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715404406838-92b5ba98-d230-4d07-95f6-10099625eae5.jpg'),
    KoreanFood(
        id: 5,
        name: '곱창구이',
        englishName: 'Grilled Beef Tripe',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715404816393-c89282fa-b7eb-48e8-a2ec-ee2931d349da.jpg'),
    KoreanFood(
        id: 6,
        name: '닭갈비',
        englishName: 'Spicy Stir-fried Chicken',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715404874175-88efb372-8663-4beb-88ec-858be9e4f2d8.jpg'),
    KoreanFood(
        id: 7,
        name: '더덕구이',
        englishName: 'Grilled Deodeok',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715404936606-42d2d70a-8c30-4956-9e22-558c67fd167e.jpg'),
    KoreanFood(
        id: 8,
        name: '떡갈비',
        englishName: 'Grilled Short Rib Patties',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715404997733-f3dc1126-9328-42d1-bace-32b246da4cfd.jpg'),
    KoreanFood(
        id: 9,
        name: '불고기',
        englishName: 'Bulgogi',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405064205-14918142-c4b0-41f5-817c-bb629f58cdfd.jpg'),
    KoreanFood(
        id: 10,
        name: '삼겹살',
        englishName: 'Grilled Pork Belly',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405140993-70728440-36eb-473d-86c9-3b7d0d113459.jpg'),
    KoreanFood(
        id: 11,
        name: '장어구이',
        englishName: 'Grilled Eel',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405194978-e3999956-b8c6-4f94-9a52-2c46ef8a7ead.jpg'),
    KoreanFood(
        id: 12,
        name: '조개구이',
        englishName: 'Grilled Clams',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405243607-238823d6-2172-425c-b725-46e2b130bf9f.jpg'),
    KoreanFood(
        id: 13,
        name: '훈제오리',
        englishName: 'Smoked Duck',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405390983-43e7bff5-5fac-433d-91a5-70a67c7635a1.jpg'),
    KoreanFood(
        id: 14,
        name: '떡만둣국',
        englishName: 'Sliced Rice Cake and Dumpling Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405486332-c252bc26-1098-46d8-9c95-eef7cca956ac.jpg'),
    KoreanFood(
        id: 15,
        name: '육개장',
        englishName: 'Spicy Beef Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405745995-cc9e10fe-c3b8-4113-aa32-d2988e79f599.jpg'),
    KoreanFood(
        id: 16,
        name: '콩나물국',
        englishName: 'Bean Sprout Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715405808856-fb1c8342-7355-4ebe-a419-1d6dba783d9b.jpg'),
    KoreanFood(
        id: 17,
        name: '만두',
        englishName: 'Dumplings',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715407767185-f81dc9d9-cd89-4212-b839-757192d350b4.jpg'),
    KoreanFood(
        id: 18,
        name: '막국수',
        englishName: 'Buckwheat Noodles',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715407812797-35846aa3-01f4-4608-aa01-8cf1d0badf9b.jpg'),
    KoreanFood(
        id: 19,
        name: '냉면',
        englishName: 'Cold Noodles',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715407886020-c84a2712-3f6a-4ee6-9cbf-b24df4fa093e.jpg'),
    KoreanFood(
        id: 20,
        name: '수제비',
        englishName: 'Hand-pulled Dough Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408006116-cbb07421-4b8e-497c-837b-53406831cb50.jpg'),
    KoreanFood(
        id: 21,
        name: '국수',
        englishName: 'Noodles',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408116342-a8c2cf07-1b11-45e2-9557-eff44020625d.jpg'),
    KoreanFood(
        id: 22,
        name: '짜장면',
        englishName: 'Jajangmyeon',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408177649-def3dbbd-3a5d-4070-b3ea-a04dc3be2bbd.jpg'),
    KoreanFood(
        id: 23,
        name: '짬뽕',
        englishName: 'Jjambbong',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408242438-5287a58b-a20f-47f7-b932-2371ca59dbed.jpg'),
    KoreanFood(
        id: 24,
        name: '쫄면',
        englishName: 'Spicy Chewy Noodles',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408292952-52214eb0-4eff-4644-a9bb-e5ba76d765f5.jpg'),
    KoreanFood(
        id: 25,
        name: '칼국수',
        englishName: 'Noodle Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408377709-cb8f9ec6-3d3b-4aae-a578-4b8880837f18.jpg'),
    KoreanFood(
        id: 26,
        name: '콩국수',
        englishName: 'Noodles in Cold Soybean Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408452291-b09195cc-71a8-4cf6-85b4-cfe07d1aff50.jpg'),
    KoreanFood(
        id: 27,
        name: '도토리묵',
        englishName: 'Acorn Jelly Salad',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408620379-2fdab7a4-2ed6-47c6-bdc7-8ede91b6c8b9.jpg'),
    KoreanFood(
        id: 28,
        name: '김밥',
        englishName: 'Gimbap',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715408972672-16ce3828-dc69-4ab7-a14a-87e703c8e52a.jpg'),
    KoreanFood(
        id: 29,
        name: '볶음밥',
        englishName: 'Fried Rice',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409058336-5b3ea650-83de-45d1-bd58-16ee3c584fdd.jpg'),
    KoreanFood(
        id: 30,
        name: '비빔밥',
        englishName: 'Bibimbap',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409170589-cbfbdbe5-08e8-4846-93ef-d0ffdd9d79af.jpeg'),
    KoreanFood(
        id: 31,
        name: '알밥',
        englishName: 'Fish Roe Rice',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409295142-a9b113a6-2b0e-493c-83b6-4b09181d5409.jpeg'),
    KoreanFood(
        id: 32,
        name: '주먹밥',
        englishName: 'Riceballs',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409455184-17f32aff-6f7b-4c87-8639-d1653289b67d.jpeg'),
    KoreanFood(
        id: 33,
        name: '두부김치',
        englishName: 'Bean Curd with Stir-fried Kimchi',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409663056-84cd61c4-5a1f-4711-85e4-c47f04b30343.jpeg'),
    KoreanFood(
        id: 34,
        name: '떡볶이',
        englishName: 'Stir-fried Rice Cake',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409711885-28858d17-a1dc-49ff-a4fd-f4bbb5d7efc6.png'),
    KoreanFood(
        id: 35,
        name: '제육볶음',
        englishName: 'Stir-fried Pork',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715409971355-02cd613a-3411-44d1-8e64-e7a93b56de83.jpeg'),
    KoreanFood(
        id: 36,
        name: '쭈꾸미',
        englishName: 'Stir-fried Webfoot Octopus',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715410041366-1c4bfe50-e74a-4105-913c-263d8abd6350.jpeg'),
    KoreanFood(
        id: 37,
        name: '보쌈',
        englishName: 'Napa Wraps with Pork',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715410097023-d70c3e3f-2870-4bb7-a68c-27ee386e05ed.jpeg'),
    KoreanFood(
        id: 38,
        name: '간장게장',
        englishName: 'Soy Sauce Marinated Crab',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715410251085-f6a3857d-1b8b-4bd1-8eee-4818befc2e43.jpeg'),
    KoreanFood(
        id: 39,
        name: '전',
        englishName: 'Pancake',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715410847426-5f425327-3f6c-4c19-b39d-3d2df60c0eed.jpeg'),
    KoreanFood(
        id: 40,
        name: '곱창전골',
        englishName: 'Beef Tripe Hot Pot',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715411462385-2850003e-2c87-43d1-93f1-314d6270862b.jpeg'),
    KoreanFood(
        id: 41,
        name: '생선조림',
        englishName: 'Braised Fish',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715411517059-57d42eb9-f809-4e4a-af4e-1a7efd7a42a5.jpeg'),
    KoreanFood(
        id: 42,
        name: '두부조림',
        englishName: 'Braised Bean Curd',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715411801812-5f7aa706-d1f5-4385-a6a4-8b7d3c613145.jpeg'),
    KoreanFood(
        id: 43,
        name: '코다리조림',
        englishName: 'Braised Half-dried Pollack',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412114242-691dbbf9-7345-4f55-b22f-7ec134c11bba.jpg'),
    KoreanFood(
        id: 44,
        name: '죽',
        englishName: 'Porridge',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412160147-aa723d1d-5b15-4aba-89be-5fb0e41fdabe.jpg'),
    KoreanFood(
        id: 45,
        name: '김치찌개',
        englishName: 'Kimchi Stew',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412273468-784dcfb9-07e6-4545-8585-ca44fe3ccf84.jpg'),
    KoreanFood(
        id: 46,
        name: '닭계장',
        englishName: 'Spicy Chicken Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412326154-5a6d5c4c-3b5c-486a-b1ad-301dde90aa86.jpg'),
    KoreanFood(
        id: 47,
        name: '동태찌개',
        englishName: 'Pollack Stew',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412373894-24a4fdf4-c2ac-4d1b-b7ea-4792e1b1e055.jpg'),
    KoreanFood(
        id: 48,
        name: '된장찌개',
        englishName: 'Soybean Paste Stew',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412416540-bb5676da-d415-4733-b388-a756b2bae350.jpg'),
    KoreanFood(
        id: 49,
        name: '순두부찌개',
        englishName: 'Soft Bean Curd Stew',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412469108-08887a80-0181-4959-8047-2cda1b3c7988.jpg'),
    KoreanFood(
        id: 50,
        name: '갈비찜',
        englishName: 'Braised Short Ribs',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412521348-b2548044-056e-4a11-9348-ea7e978c29a1.jpg'),
    KoreanFood(
        id: 51,
        name: '김치찜',
        englishName: 'Braised Pork with Aged Kimchi',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412621159-0a8a6d66-cdc1-49c7-88dd-e01f0ebcbfc7.jpeg'),
    KoreanFood(
        id: 52,
        name: '꼬막찜',
        englishName: 'Steamed Cockles',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412712446-4d428b26-bae2-402b-8777-15f73ebe28c9.jpeg'),
    KoreanFood(
        id: 53,
        name: '닭볶음탕',
        englishName: 'Spicy Braised Chicken',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412764314-414a79f3-288f-4057-9a24-c8a4a81f1d6c.jpeg'),
    KoreanFood(
        id: 54,
        name: '수육 족발',
        englishName: "Boiled Beef Slices & Braised Pigs' Feet",
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412824504-8d777103-5393-46c3-9943-f8acf9310bf4.jpeg'),
    KoreanFood(
        id: 55,
        name: '순대',
        englishName: 'Sundae',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715412880893-a6d21d71-27a6-4dab-9c09-4f9386b355eb.jpeg'),
    KoreanFood(
        id: 56,
        name: '찜닭',
        englishName: 'Braised Chicken',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413025111-ad089dc3-7341-4048-87b7-35621a95383c.jpeg'),
    KoreanFood(
        id: 57,
        name: '해물찜',
        englishName: 'Spicy Braised Seafood',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413073657-8bb7ae06-884b-43f9-821f-027e1adc6725.jpeg'),
    KoreanFood(
        id: 58,
        name: '갈비탕',
        englishName: 'Short Rib Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413117651-634986af-425f-474d-bd29-4dda07852795.jpeg'),
    KoreanFood(
        id: 59,
        name: '감자탕',
        englishName: 'Pork Back-bone Stew',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413165938-e874518f-0faf-4971-8ee9-78f1a4298248.jpeg'),
    KoreanFood(
        id: 60,
        name: '설렁탕',
        englishName: 'Beef Bone Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413269321-777efd5e-02c3-4bc8-ac46-93a15f1c52ab.jpeg'),
    KoreanFood(
        id: 61,
        name: '매운탕',
        englishName: 'Spicy Fish Stew',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413372931-897ee0b0-3bd1-4dec-955a-428cea8d8b04.jpeg'),
    KoreanFood(
        id: 62,
        name: '삼계탕',
        englishName: 'Ginseng Chicken Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413428955-6e9ec802-5f6d-41d0-a0cb-0e0fe4e58d02.jpeg'),
    KoreanFood(
        id: 63,
        name: '추어탕',
        englishName: 'Loach Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413490143-64aa473a-c211-49f7-94c8-86a1cf4f1d08.jpeg'),
    KoreanFood(
        id: 64,
        name: '튀김',
        englishName: 'Fried Food',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413596990-6b4b4284-8735-447d-ab38-ce603d340ace.jpeg'),
    KoreanFood(
        id: 65,
        name: '산낙지',
        englishName: 'Live Octopus',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413916165-ed0f5d01-8a85-4dc9-a275-4d436d4871c6.jpg'),
    KoreanFood(
        id: 66,
        name: '물회',
        englishName: 'Cold Raw Fish Soup',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413941541-f7b2b72c-cf75-4fad-8c50-40a2d77e57fc.jpeg'),
    KoreanFood(
        id: 67,
        name: '육회',
        englishName: 'Beef Tartare',
        imageUrl:
            'static.kfoodbox.click/foods/2024/05/11/1715413976417-5a5a2092-be6f-414b-b2ac-cb03676460ad.jpg'),
  ];
}
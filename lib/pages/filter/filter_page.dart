import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedTab = '학과별 분류';
  String? selectedCategory;

  final List<String> regionList = [
    '서울', '인천', '경기', '대전', '대구', '부산', '강원', '광주', '울산',
    '경남', '경북', '전남', '전북', '제주'
  ];

  final Map<String, List<List<String>>> regionSchoolMap = {
    '서울': [],
    '인천': [],
    '경기': [],
    '대전': [
      ['건양대학교', '대전과학기술대학교'],
      ['대전대학교', '한국폴리텍IV대학'],
      ['대전신학대학교', '건신대학원대학교'],
      ['국군간호사관학교', '대전보건대학교'],
      ['국립한밭대학교', '우송정보대학'],
      ['목원대학교', '과학기술연합대학원대학교'],
      ['배재대학교', '건양사이버대학교'],
      ['우송대학교', '원광디지털대학교'],
      ['울지대학교'],
      ['침례신학대학교'],
      ['충남대학교'],
      ['한국과학기술원'],
      ['한국방송통신대학교'],
      ['한남대학교'],
      ['합동군사대학교'],
      ['대덕대학교'],
      ['제어계측공학']
    ],
    '대구': [],
    '부산': [],
    '강원': [],
    '광주': [],
    '울산': [],
    '경남': [],
    '경북': [],
    '전남': [],
    '전북': [],
    '제주': []
  };

  final Map<String, List<String>> majorCategories = {
    '학과별 분류': ['인문계열', '사회계열', '자연계열', '공학계열', '의약계열', '예체능계열', '교육계열'],
  };

  final Map<String, List<String>> majorOptions = {
    '인문계열': [],
    '사회계열': [],
    '자연계열': [],
    '공학계열': [
      '건축학', '건축설비공학', '조경학', '지상교통공학', '항공학', '해양공학', '금속공학', '기계공학',
      '자동차공학', '섬유공학', '산업공학', '반도체공학', '신소재공학', '재료공학', '전기공학', '전자공학', '제어계측공학',
      '에너지공학', '응용소프트웨어공학', '전산학', '컴퓨터공학', '정보통신공학', '도시공학', '토목공학', '화학공학'
    ],
    '의약계열': [],
    '예체능계열': [],
    '교육계열': [],
  };

  @override
  void initState() {
    super.initState();
    selectedCategory = selectedTab == '학과별 분류'
        ? majorCategories[selectedTab]!.first
        : regionList.first;
  }

  void _onFilterSelected(String value) {
    if (value == '컴퓨터공학') {
      Navigator.pushNamed(context, '/board');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DapTopBar(title: '카테고리 검색'),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        selectedTab = '학과별 분류';
                        selectedCategory = majorCategories[selectedTab]!.first;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          '학과별 분류',
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontWeight: FontWeight.bold,
                            color: selectedTab == '학과별 분류'
                                ? const Color(0xFF2C4D14)
                                : Colors.black,
                            decoration: selectedTab == '학과별 분류'
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        selectedTab = '학교별 분류';
                        selectedCategory = regionList.first;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text(
                          '학교별 분류',
                          style: TextStyle(
                            fontFamily: 'GmarketSans',
                            fontWeight: FontWeight.bold,
                            color: selectedTab == '학교별 분류'
                                ? const Color(0xFF2C4D14)
                                : Colors.black,
                            decoration: selectedTab == '학교별 분류'
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 1),
              Expanded(
                child: Row(
                  children: [
                    // 왼쪽 카테고리
                    Container(
                      width: 120,
                      color: Colors.white,
                      child: ListView(
                        children: (selectedTab == '학과별 분류'
                            ? majorCategories[selectedTab]!
                            : regionList)
                            .map((category) => GestureDetector(
                          onTap: () =>
                              setState(() => selectedCategory = category),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            color: selectedCategory == category
                                ? const Color(0xFFF6DCDD)
                                : Colors.white,
                            child: Text(
                              category,
                              style: TextStyle(
                                fontFamily: 'GmarketSans',
                                fontWeight: selectedCategory == category
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectedCategory == category
                                    ? const Color(0xFF2C4D14)
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    // 오른쪽 리스트
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: (selectedTab == '학과별 분류'
                              ? (majorOptions[selectedCategory] ?? [])
                              : (regionSchoolMap[selectedCategory] ?? [])
                              .expand((pair) => pair))
                              .map((item) => GestureDetector(
                            onTap: () => _onFilterSelected(item),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFFCCCCCC)),
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontFamily: 'GmarketSans',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

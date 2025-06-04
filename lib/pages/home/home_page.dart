import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import '../chat/chat_page.dart';
import '../board/board_page.dart';
import '../post/question_detail_page.dart';  // QuestionDetailPage import 추가

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 2;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DapTopBar(
          title: 'Dap&Dap',
          showBack: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.smart_toy_outlined, color: Colors.white),
              tooltip: 'AI 어시스트',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 160,
                child: PageView(
                  controller: _pageController,
                  children: [
                    _BannerCard(
                      title: '질문하기',
                      subtitle: '빠르고 정확한 답변보기',
                      imageAsset: 'image/q2.png',
                      backgroundColor: const Color(0xFF2C4D14),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BoardPage(onNavigate: (_) {}),
                          ),
                        );
                      },
                    ),
                    _BannerCard(
                      title: '답변하기',
                      subtitle: '나의 지식 공유하기',
                      imageAsset: 'image/q1.png',
                      backgroundColor: const Color(0xFFF6DCDD),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('오늘의 맞춤DapDap',
                      style: TextStyle(
                          fontFamily: 'GmarketSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text('더보기',
                      style: TextStyle(fontFamily: 'Pretendard', color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF6DCDD), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    _TodayItem(title: '확률 및 통계', question: 'f(x) = λe^(−λx)일 때 누적분포함수 F(x)는'),
                    _TodayItem(title: '논리회로', question: '비동기 카운터 d flip flop으로 설계할 때'),
                    _TodayItem(title: '논리회로', question: 'Moore machine VS Mealy machine'),
                    _TodayItem(title: '선형대수학', question: 'N*M 크기의 행렬에 rank=3일 때 해의 개수'),
                    _TodayItem(title: '자료구조', question: '이진탐색트리 경로압축 미사용시 수행시간'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('나의 DapDap',
                      style: TextStyle(
                          fontFamily: 'GmarketSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text('더보기',
                      style: TextStyle(fontFamily: 'Pretendard', color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 260,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _MyDapCard(
                      title: 'CDF 문제풀이',
                      time: '10분 전',
                      image: 'image/mydap1.png',
                      tags: ['#확률및통계', '#대학수학'],
                      comments: 1,
                      note: '1개의 확인하지 않은 답변이 있어요!',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuestionDetailPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _MyDapCard(
                      title: '논리회로 MUX 사용',
                      time: '어제',
                      image: 'image/mydap2.png',
                      tags: ['#논리회로', '#공과대학'],
                      comments: 3,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuestionDetailPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const _BannerCard({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontFamily: 'GmarketSans',
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(subtitle,
                      style: const TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Image.asset(
              imageAsset,
              height: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayItem extends StatelessWidget {
  final String title;
  final String question;

  const _TodayItem({required this.title, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(title,
                style: const TextStyle(
                    fontFamily: 'GmarketSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF2C4D14))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(question, style: const TextStyle(fontFamily: 'Pretendard'))),
        ],
      ),
    );
  }
}

class _MyDapCard extends StatelessWidget {
  final String title;
  final String time;
  final String image;
  final List<String> tags;
  final int comments;
  final String? note;
  final VoidCallback? onTap;  // 추가

  const _MyDapCard({
    required this.title,
    required this.time,
    required this.image,
    required this.tags,
    required this.comments,
    this.note,
    this.onTap,  // 추가
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // 클릭 시 호출
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: const Color(0xFFF6DCDD),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontFamily: 'GmarketSans', fontWeight: FontWeight.bold)),
                ),
                Text(time,
                    style: const TextStyle(fontFamily: 'Pretendard', fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF2C4D14)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 2,
              children: tags
                  .map((tag) => Chip(
                label: Text(tag,
                    style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        color: Colors.white)),
                backgroundColor: const Color(0xFF2C4D14),
                padding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity:
                const VisualDensity(horizontal: -4, vertical: -4),
              ))
                  .toList(),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.comment, size: 14),
                const SizedBox(width: 4),
                Text('$comments개',
                    style: const TextStyle(fontFamily: 'Pretendard')),
              ],
            ),
            if (note != null) ...[
              const SizedBox(height: 4),
              Text(note!,
                  style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 11,
                      color: Colors.grey)),
            ]
          ],
        ),
      ),
    );
  }
}
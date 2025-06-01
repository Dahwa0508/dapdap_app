import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';

class BoardPage extends StatelessWidget {
  final void Function(String) onNavigate;

  const BoardPage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> posts = [
      {
        'title': '확률과 통계 CDF 질문이요',
        'content': '아래 문제를 어떻게 푸는지 모르겠습니다. 풀이과정을 자세히 적어 주실 수 있나요?',
        'tags': ['#확률 및 통계', '#문제풀이', '#CDF', '#충남대학교'],
        'time': '10분 전',
        'isVerified': true,
        'comments': 1,
        'thumbnail': 'assets/images/post1.png',
      },
      {
        'title': 'D 플립플랍 설계',
        'content': '내일 실습인데 예습문제 풀던 중에 질문드립니다.',
        'tags': ['#논리회로', '#D 플립플랍', '#조합회로', '#충북대학교'],
        'time': '10분 전',
        'isVerified': true,
        'comments': 3,
        'thumbnail': 'assets/images/post2.png',
      },
      {
        'title': '카르노맵 복습중인데요...',
        'content': '이렇게 생긴 카르노맵도 있나요?? 제가 그린 것도 맞는지 확인 부탁드려요,,',
        'tags': ['#논리회로', '#카르노맵', '#서울과학기술대학교'],
        'time': '13분 전',
        'isVerified': true,
        'comments': 3,
        'thumbnail': 'assets/images/post3.png',
      },
      {
        'title': '나이 기준 정렬 문제 대체 뭐가 문제??',
        'content': '테스트 케이스 1, 4가 계속 통과가 안 돼요ㅠㅠ',
        'tags': ['#컴퓨터프로그래밍 3', '#구조체', '#버블정렬'],
        'time': '13분 전',
        'isVerified': true,
        'comments': 3,
        'thumbnail': 'assets/images/post4.png',
      },
      {
        'title': '독립임을 증명하시오',
        'content': '',
        'tags': ['#확률 및 통계', '#문제풀이', '#독립'],
        'time': '13분 전',
        'isVerified': true,
        'comments': 0,
        'thumbnail': 'assets/images/post5.png',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DapTopBar(title: '학과별 게시판', onNavigate: onNavigate),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: const [
                Text(
                  '컴퓨터공학',
                  style: TextStyle(
                    fontFamily: 'GmarketSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down),
                Spacer(),
                Icon(Icons.search),
              ],
            ),
          ),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(width: 4),
                Chip(
                  label: Text('#확률 및 통계', style: TextStyle(color: Colors.white)),
                  backgroundColor: Color(0xFF2C4D14),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text('#논리회로', style: TextStyle(color: Colors.white)),
                  backgroundColor: Color(0xFF2C4D14),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text('#컴퓨터프로그래밍 3', style: TextStyle(color: Colors.white)),
                  backgroundColor: Color(0xFF2C4D14),
                ),
                SizedBox(width: 8),
                Chip(
                  label: Text('#데이터베이스설계', style: TextStyle(color: Colors.white)),
                  backgroundColor: Color(0xFF2C4D14),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              separatorBuilder: (_, __) =>
              const Divider(color: Colors.grey, height: 32),
              itemBuilder: (context, index) {
                final post = posts[index];
                return Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: post['tags']
                                  .map<Widget>((tag) => Chip(
                                label: Text(
                                  tag,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Pretendard',
                                    color: Colors.black,
                                  ),
                                ),
                                backgroundColor: const Color(0xFFF6DCDD),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                              ))
                                  .toList(),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              post['title'],
                              style: const TextStyle(
                                fontFamily: 'GmarketSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (post['content'].toString().isNotEmpty)
                              Text(
                                post['content'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                const TextStyle(fontFamily: 'Pretendard'),
                              ),
                            const SizedBox(height: 4),
                            Text(
                              '${post['time']} · ${post['isVerified'] ? '인증됨' : ''}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                post['thumbnail'],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.comment, size: 16),
                              const SizedBox(width: 2),
                              Text(
                                post['comments'].toString(),
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2C4D14),
        shape: const CircleBorder(),
        elevation: 4,
        onPressed: () => onNavigate('post'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

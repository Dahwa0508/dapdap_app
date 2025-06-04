import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import 'drawing_board_page.dart'; // DrawingBoardPage import

class QuestionDetailPage extends StatelessWidget {
  const QuestionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DapTopBar(title: '질문 상세', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 작성자 정보
          Row(
            children: const [
              CircleAvatar(radius: 20, backgroundColor: Colors.green),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('비공개', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '인증된 사용자 · 10분 전',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),

          // 질문 제목 및 본문
          const Text(
            '확률과 통계 CDF 질문이요',
            style: TextStyle(
              fontFamily: 'GmarketSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '아래 문제를 어떻게 푸는지 모르겠습니다. 풀이과정을 자세히 적어 주실 수 있나요?',
            style: TextStyle(fontFamily: 'Pretendard'),
          ),
          const SizedBox(height: 16),

          // 문제 설명 (간단 텍스트 처리)
          const Text(
            'Question 1',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          const Text(
            'X가 c.d.f F인 연속확률변수라고 하자. Constant a, b에 대해 ...에 대해 W의 c.d.f를 구하시오.',
            style: TextStyle(fontFamily: 'Pretendard'),
          ),
          const SizedBox(height: 16),

          // 이미지 클릭 시 DrawingBoardPage로 이동
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DrawingBoardPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('image/board.png'),
            ),
          ),
          const SizedBox(height: 16),

          // 자동 태그
          Wrap(
            spacing: 6,
            children: const [
              Chip(label: Text('#확률 및 통계')),
              Chip(label: Text('#문제풀이')),
              Chip(label: Text('#CDF')),
            ],
          ),
          const SizedBox(height: 16),

          // AI 요약
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF2C4D14)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '3명의 유사한 질문 중 이 문제와 유사한 질문이 다녀갔어요.',
              style: TextStyle(fontFamily: 'Pretendard'),
            ),
          ),
          const SizedBox(height: 24),

          // 댓글 타이틀
          Row(
            children: const [
              Icon(Icons.comment, size: 20, color: Color(0xFF2C4D14)),
              SizedBox(width: 8),
              Text('댓글 2', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),

          // 댓글 카드
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(radius: 14, backgroundColor: Colors.orange),
                    SizedBox(width: 8),
                    Text('무리하는 감자', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Text(
                      '답변 만족도 90%',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  '다음과 같이 확률변수의 누적분포함수를 구할 때는 ... 혹시 더 궁금한 점 있으실까요?',
                  style: TextStyle(fontFamily: 'Pretendard'),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('image/answer_math.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

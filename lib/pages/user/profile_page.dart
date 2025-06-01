import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  final void Function(String) onNavigate;

  const ProfilePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DapTopBar(title: '마이페이지', onNavigate: onNavigate),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF2C4D14), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('image/guinea.png'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    '거노1110',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '3일 정지',
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF9DDE1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  '충남대학교 컴퓨터융합학부',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Icon(Icons.water_drop,
                                      color: Colors.pink, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '연속 6일 공부',
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoColumn('2', '쿠폰함'),
                        _infoColumn('184739274 P', '쿠폰 전환하기'),
                        _infoColumn('Lv.3', '멘토력 등급 보기'),
                      ],
                    ),
                  ),
                  const Divider(height: 32),
                  _section(context, '게시물', ['최근 질문', '최근 댓글']),
                  _section(context, '멘토력 관리', ['최근 답변', '답답지수']),
                  _section(context, '유용한 기능', ['설문조사', '멘토멘티', '스터디 구하기']),
                  _section(context, '관리', ['결제 내역']),
                  _section(context, '계정', ['로그아웃']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _section(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C4D14),
              fontSize: 16,
            ),
          ),
        ),
        ...items.map(
              (text) => ListTile(
            title: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (text == '답답지수') {
                onNavigate('ranking');
              } else if (text == '로그아웃') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginSignupScreen()),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

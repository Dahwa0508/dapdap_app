import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E4CB),
      appBar: DapTopBar(
        title: 'DapDapAI',
        onNavigate: (route) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _dateLabel('5월 26일'),
                _botMessage('안녕! 4일째 공부하고 있네\n오늘도 열공🔥'),
                _dateLabel('5월 27일'),
                _botMessage(
                    '5일째 연속 출석중! 대단해😲\n최근 논리회로 플립플랍 질문을 자주 하길래 유익한 강의 추천해줄게\nhttps://youtu.be/0Jc6iD91jAY?si=KRul1QtaJCbXXZ23',
                    includeImage: true),
                _dateLabel('5월 28일'),
                _userMessage('내일 논리회로 쪽지시험인데, 유사문제 10개 만들어줘!'),
                _botMessage('알겠어! 유사문제 10문제 만들어 봤어😎'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black87,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E7CB),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: const Text(''),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.send, size: 28, color: Colors.black87),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateLabel(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(thickness: 1, endIndent: 8)),
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Expanded(child: Divider(thickness: 1, indent: 8)),
        ],
      ),
    );
  }

  Widget _botMessage(String message, {bool includeImage = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/dapdap1.png'),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(message),
              ),
              if (includeImage)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'image/teacher.png',
                    height: 180,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _userMessage(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2C4D14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(message,
                style: const TextStyle(color: Colors.white, fontFamily: 'Pretendard')),
          ),
        ),
      ],
    );
  }
}

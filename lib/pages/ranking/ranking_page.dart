import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  static final List<Map<String, String>> users = [
    {
      'name': '충남대 베토벤',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 364일 공부'
    },
    {
      'name': '종강이다!!',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 6일 공부'
    },
    {
      'name': '회피기니',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 6일 공부'
    },
    {
      'name': 'due..',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 6일 공부'
    },
    {
      'name': '거노1110',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 6일 공부'
    },
    {
      'name': '우리귀살대는언제나너희편',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 6일 공부'
    },
    {
      'name': '수시포터',
      'department': '충남대학교 컴퓨터융합학부',
      'days': '연속 6일 공부'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DapTopBar(title: '답답지수'),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade800),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 24,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  user['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9DDE1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user['department']!,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user['days']!,
                      style: const TextStyle(color: Colors.pink, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

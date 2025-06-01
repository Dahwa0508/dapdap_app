import 'package:flutter/material.dart';
import '../../widgets/top_app_bar.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DapTopBar(title: '나의 질문'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: const [
              SectionTitle('저장한 질문'),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: BookmarkCard(isPink: false)),
                  SizedBox(width: 12),
                  Expanded(child: BookmarkCard(isPink: false)),
                ],
              ),
              SizedBox(height: 32),
              SectionTitle('작성한 질문'),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: BookmarkCard(isPink: true)),
                  SizedBox(width: 12),
                  Expanded(child: BookmarkCard(isPink: true)),
                ],
              ),
              SizedBox(height: 32),
              SectionTitle('답변한 질문'),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: BookmarkCard(isPink: false)),
                  SizedBox(width: 12),
                  Expanded(child: BookmarkCard(isPink: false)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'GmarketSans',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

class BookmarkCard extends StatelessWidget {
  final bool isPink;
  const BookmarkCard({super.key, required this.isPink});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPink ? const Color(0xFFF6DCDD) : const Color(0xFF2C4D14),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  '논리회로 MUX 사용',
                  style: TextStyle(
                    fontFamily: 'GmarketSans',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '어제',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: isPink ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isPink ? Colors.white : Colors.green),
              ),
              child: const Center(child: Icon(Icons.image)),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: const [
              Chip(
                label: Text('#논리회로', style: TextStyle(fontSize: 11)),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                label: Text('#공학계열', style: TextStyle(fontSize: 11)),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.comment, size: 14),
              const SizedBox(width: 4),
              const Text('3개', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 6),
              if (isPink)
                const Text(
                  '1개의 확인하지 않은 답변이 있어요!',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                )
            ],
          ),
        ],
      ),
    );
  }
}

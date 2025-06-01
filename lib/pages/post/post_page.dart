import 'package:flutter/material.dart';
import 'drawing_board_page.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "글 작성",
          style: TextStyle(
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2C4D14),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const PostForm(),
    );
  }
}

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  int _selectedToolIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '확률 및 통계',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GmarketSans',
                color: Color(0xFF2C4D14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '제목을 입력하세요',
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'GmarketSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _bodyController,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요.',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontFamily: 'Pretendard'),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _iconWithText(Icons.camera_alt, '카메라', 0, () {}),
              _iconWithText(Icons.image, '사진', 1, () {}),
              _iconWithText(Icons.add_box, '칠판 사용', 2, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }),
              _iconWithText(Icons.menu_book, '교재정보', 3, () {}),
              _iconWithText(Icons.tag, '태그', 4, () {}),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print("제목: ${_titleController.text}");
                  print("내용: ${_bodyController.text}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('질문이 등록되었습니다')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C4D14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  '등록',
                  style: TextStyle(color: Colors.white, fontFamily: 'Pretendard'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconWithText(
      IconData icon, String label, int index, VoidCallback onTap) {
    final isSelected = _selectedToolIndex == index;
    final color = isSelected ? const Color(0xFF2C4D14) : Colors.grey;

    return InkWell(
      onTap: () {
        setState(() => _selectedToolIndex = index);
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                color: color,
                fontFamily: 'Pretendard',
              )),
        ],
      ),
    );
  }
}

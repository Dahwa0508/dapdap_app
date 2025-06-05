import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/top_app_bar.dart';
import '../../env/env.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  DateTime _lastRequestTime = DateTime.now().subtract(const Duration(seconds: 1));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String message) async {
    if (message.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': message});
      _isLoading = true;
    });

    try {
      // 최소 1초 딜레이로 rate limiting (429 방지)
      final now = DateTime.now();
      final difference = now.difference(_lastRequestTime);
      if (difference.inMilliseconds < 1000) {
        await Future.delayed(Duration(milliseconds: 1000 - difference.inMilliseconds));
      }
      _lastRequestTime = DateTime.now();

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Env.apiKey}',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': '너는 한국 대학생 전공 과목 질문에 답변하는 AI야. 개념을 쉽게 설명하고, 질문자가 잘 이해할 수 있도록 예시도 같이 들어줘. 문장은 너무 길지 않게, 말투는 친근하게 해줘. 이모티콘도 가끔 써줘.'},
            ..._messages.map((m) => {'role': m['role'], 'content': m['content']}),
            {'role': 'user', 'content': message}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'];

        setState(() {
          _messages.add({'role': 'assistant', 'content': reply});
        });
      } else {
        print('⚠️ 서버 오류: ${response.statusCode}');
        print('⚠️ 응답 본문: ${response.body}');
        setState(() {
          _messages.add({
            'role': 'assistant',
            'content': '⚠️ 오류가 발생했습니다. (Status: ${response.statusCode})'
          });
        });
      }
    } catch (e, stackTrace) {
      print('⚠️ 예외 발생: $e');
      print('⚠️ 스택 트레이스: $stackTrace');
      setState(() {
        _messages.add({
          'role': 'assistant',
          'content': '⚠️ 네트워크 오류가 발생했습니다. (${e.toString()})'
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message['role'] == 'user') {
                  return _userMessage(message['content']);
                } else {
                  return _botMessage(message['content']);
                }
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
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
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '메시지를 입력하세요...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _sendMessage(value.trim());
                        _controller.clear();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, size: 28, color: Colors.black87),
                  onPressed: () {
                    _sendMessage(_controller.text.trim());
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botMessage(String message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/dapdap1.png'),
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(message),
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
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Pretendard',
              ),
            ),
          ),
        ),
      ],
    );
  }
}



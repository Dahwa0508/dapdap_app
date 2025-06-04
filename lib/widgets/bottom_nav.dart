// lib/widgets/bottom_nav.dart
import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/user/bookmark_page.dart';
import '../pages/filter/filter_page.dart';
import '../pages/board/board_page.dart';
import '../pages/user/profile_page.dart';
import '../pages/ranking/ranking_page.dart';
import '../pages/edit/post_edit.dart';
import '../pages/auth/login_page.dart';

class MainScaffold extends StatefulWidget {
  final int initialIndex;

  const MainScaffold({super.key, this.initialIndex = 2}); // 기본 홈 (index 2)

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateTo(String route) {
    late Widget page;

    switch (route) {
      case 'ranking':
        page = const RankingPage();
        break;
      case 'post':
        page = const PostEdit();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    ).then((_) {
      setState(() {}); // 돌아왔을 때 상태 갱신
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return BoardPage(onNavigate: _navigateTo);
      case 1:
        return const FilterPage();
      case 2:
        return const HomePage();
      case 3:
        return const BookmarkPage();
      case 4:
        return ProfilePage(onNavigate: _navigateTo);
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF2C4D14),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '게시판'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: '북마크'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '사용자'),
        ],
      ),
    );
  }
}

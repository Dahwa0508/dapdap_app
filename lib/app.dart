import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';
import 'pages/post/post_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dap&Dap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Pretendard',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Pretendard', fontSize: 18),
          bodyMedium: TextStyle(fontFamily: 'Pretendard', fontSize: 16),
          bodySmall: TextStyle(fontFamily: 'Pretendard', fontSize: 14),
          titleMedium: TextStyle(fontFamily: 'Pretendard', fontSize: 18),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C4D14),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MainScaffold(),
      routes: {
        '/post': (context) => const PostPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';

class DapTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onBackTap; // 상태 기반 처리용
  final void Function(String)? onNavigate;
  final bool showBack;
  final List<Widget>? actions;

  const DapTopBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.onNavigate,
    this.showBack = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF2C4D14),
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'GmarketSans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      leading: showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () async {
          if (onBackTap != null) {
            onBackTap!(); // 상태 기반으로 화면 전환
          } else {
            final didPop = await Navigator.of(context).maybePop();
            if (!didPop && onNavigate != null) {
              onNavigate!("home");
            }
          }
        },
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

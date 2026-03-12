import 'package:flutter/material.dart';
import 'package:mvvm_project/views/api_images/api_images_page.dart';
import 'package:mvvm_project/views/flutter_overview_page.dart';
import 'package:mvvm_project/views/home/home_header.dart';
import 'package:mvvm_project/views/home/home_menu_button.dart';
import 'package:mvvm_project/views/login_page.dart';
import 'package:mvvm_project/views/user_management/user_management_page.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/login/login_viewmodel.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String title;

  const HomePage({
    super.key,
    required this.userName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F4FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeHeader(
              title: title,
              subtitle: 'Xin chào đã đến hệ thống',
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32, left: 24, right: 24),
              child: Text(
                'Xin chào bạn đến với hệ thống quản lý cá nhân',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D4E9E),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeMenuButton(
                      icon: Icons.people_alt_outlined,
                      label: 'Quản lý người dùng',
                      iconColor: const Color(0xFF26A69A),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const UserManagementPage(),
                          ),
                        );
                      },
                    ),
                    HomeMenuButton(
                      icon: Icons.event_note,
                      label: 'Quản lý nhắc việc',
                      iconColor: Colors.orange,
                    ),
                    HomeMenuButton(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Đặt hàng',
                      iconColor: Colors.lightBlue,
                    ),
                    HomeMenuButton(
                      icon: Icons.map_outlined,
                      label: 'Xem Bản Đồ',
                      iconColor: Colors.red,
                    ),
                    HomeMenuButton(
                      icon: Icons.image_outlined,
                      label: 'Xem ảnh qua API',
                      iconColor: Colors.lightBlue,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ApiImagesPage(),
                          ),
                        );
                      },
                    ),
                    HomeMenuButton(
                      icon: Icons.flutter_dash,
                      label: 'Tổng quan Flutter',
                      iconColor: const Color(0xFF54C5F8),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FlutterOverviewPage(),
                          ),
                        );
                      },
                    ),
                    HomeMenuButton(
                      icon: Icons.power_settings_new,
                      label: 'Đăng xuất',
                      iconColor: Colors.red,
                      onTap: () => _handleLogout(context),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    await context.read<LoginViewModel>().logout();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (_) => false,
    );
  }
}

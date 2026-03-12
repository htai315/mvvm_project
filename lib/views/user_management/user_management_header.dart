import 'package:flutter/material.dart';

/// Header màu xanh dương: nút quay lại + tiêu đề + dòng mô tả.
/// Dùng cho cả màn Quản lý người dùng và màn Chi tiết người dùng và các màn trong user_management.
class UserManagementHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const UserManagementHeader({
    super.key,
    this.title = 'Quản lý người dùng',
    this.subtitle = 'Danh sách • Thêm/Sửa/Xóa',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 24, 16, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1D4E9E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

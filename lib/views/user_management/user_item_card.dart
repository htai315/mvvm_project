import 'package:flutter/material.dart';

// Card hiển thị một người dùng: avatar (chữ cái đầu), tên in đậm, ngày sinh • địa chỉ, icon mũi tên phải.
class UserItemCard extends StatelessWidget {
  final String name;
  final String dateOfBirth;
  final String address;
  final VoidCallback? onTap;

  const UserItemCard({
    super.key,
    required this.name,
    required this.dateOfBirth,
    required this.address,
    this.onTap,
  });

  String get _initial {
    if (name.isEmpty) return '?';
    return name.trim().substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black26,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Text(
                    _initial,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D4E9E),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1D4E9E),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$dateOfBirth • $address',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF1D4E9E),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

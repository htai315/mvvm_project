import 'package:flutter/material.dart';
import 'package:mvvm_project/domain/entities/managed_user.dart';
import 'package:mvvm_project/views/user_management/user_form_page.dart';
import 'package:mvvm_project/views/user_management/user_management_header.dart';

class UserDetailPage extends StatelessWidget {
  final ManagedUser user;
  final VoidCallback? onDelete;
  final Function(ManagedUser)? onUpdate;

  const UserDetailPage({
    super.key,
    required this.user,
    this.onDelete,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F4FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserManagementHeader(
              title: 'Chi tiết người dùng',
              subtitle: 'Xem thông tin • Sửa • Xóa',
            ),
            const SizedBox(height: 24),
            _buildCard(context),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                children: [
                  Expanded(
                    child: _DeleteButton(
                      onPressed: () => _confirmDelete(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _EditButton(
                      onPressed: () => _navigateToEdit(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa người dùng "${user.fullName}" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      onDelete?.call();
      Navigator.of(context).pop();
    }
  }

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.of(context).push<ManagedUser>(
      MaterialPageRoute(
        builder: (_) => UserFormPage(
          user: user,
        ),
      ),
    );

    if (result != null && context.mounted) {
      onUpdate?.call(result);
      Navigator.of(context).pop();
    }
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            user.fullName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1D4E9E),
            ),
          ),
          const SizedBox(height: 24),
          _buildRow('Ngày sinh:', user.dob),
          const SizedBox(height: 16),
          _buildRow('Địa chỉ:', user.address),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.delete_outline, size: 22, color: Colors.red),
      label: const Text(
        'Xóa',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        side: const BorderSide(color: Colors.red, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _EditButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.edit_outlined, size: 22, color: Colors.white),
      label: const Text(
        'Sửa',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1D4E9E),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}

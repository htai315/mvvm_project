import 'package:flutter/material.dart';
import 'package:mvvm_project/domain/entities/managed_user.dart';
import 'package:mvvm_project/views/user_management/user_management_header.dart';

class UserFormPage extends StatefulWidget {
  final ManagedUser? user;

  const UserFormPage({
    super.key,
    this.user,
  });

  bool get isEditMode => user != null;

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;
  late final TextEditingController _addressController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.fullName);
    _dobController = TextEditingController(text: widget.user?.dob);
    _addressController = TextEditingController(text: widget.user?.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool get _isValid {
    return _nameController.text.trim().isNotEmpty &&
        _dobController.text.trim().isNotEmpty &&
        _addressController.text.trim().isNotEmpty;
  }

  Future<void> _save() async {
    if (!_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = ManagedUser(
      id: widget.user?.id ?? 0,
      fullName: _nameController.text.trim(),
      dob: _dobController.text.trim(),
      address: _addressController.text.trim(),
      createdAt: widget.user?.createdAt ?? DateTime.now().toIso8601String(),
    );

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F4FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserManagementHeader(
              title: widget.isEditMode ? 'Sửa người dùng' : 'Thêm người dùng',
              subtitle: 'Nhập thông tin và bấm Lưu',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: _buildCard(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                children: [
                  Expanded(
                    child: _CancelButton(
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SaveButton(
                      onPressed: _isLoading ? null : _save,
                      isLoading: _isLoading,
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

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: _inputDecoration('Họ và tên'),
            style: const TextStyle(fontSize: 16),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _pickDate(context),
            borderRadius: BorderRadius.circular(12),
            child: IgnorePointer(
              child: TextField(
                controller: _dobController,
                decoration: _inputDecoration('Ngày sinh').copyWith(
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF1D4E9E),
                    size: 22,
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _addressController,
            decoration: _inputDecoration('Địa chỉ'),
            style: const TextStyle(fontSize: 16),
            maxLines: 3,
            minLines: 2,
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final initial = _parseDate(_dobController.text);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text = _formatDate(picked);
      setState(() {});
    }
  }

  DateTime? _parseDate(String s) {
    if (s.trim().isEmpty) return null;
    final parts = s.split('/');
    if (parts.length != 3) return null;
    final d = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final y = int.tryParse(parts[2]);
    if (d == null || m == null || y == null) return null;
    if (m < 1 || m > 12) return null;
    try {
      return DateTime(y, m, d);
    } catch (_) {
      return null;
    }
  }

  String _formatDate(DateTime d) {
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day/$month/${d.year}';
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1D4E9E), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CancelButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1D4E9E),
        side: const BorderSide(color: Color(0xFF1D4E9E), width: 2),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: const Text(
        'Hủy',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _SaveButton({required this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1D4E9E),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text(
              'Lưu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
    );
  }
}

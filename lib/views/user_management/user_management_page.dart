import 'package:flutter/material.dart';
import 'package:mvvm_project/domain/entities/managed_user.dart';
import 'package:mvvm_project/viewmodels/usermanagement/users_viewmodels.dart';
import 'package:mvvm_project/views/user_management/user_detail_page.dart';
import 'package:mvvm_project/views/user_management/user_form_page.dart';
import 'package:mvvm_project/views/user_management/user_item_card.dart';
import 'package:mvvm_project/views/user_management/user_management_header.dart';
import 'package:provider/provider.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersViewModels>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F4FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserManagementHeader(),
            Expanded(
              child: Consumer<UsersViewModels>(
                builder: (context, viewModel, _) {
                  if (viewModel.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF1D4E9E),
                      ),
                    );
                  }

                  if (viewModel.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            viewModel.error!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => viewModel.init(),
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (viewModel.users.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Chưa có người dùng nào',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => viewModel.refresh(),
                    color: const Color(0xFF1D4E9E),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      itemCount: viewModel.users.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.users[index];
                        return UserItemCard(
                          name: user.fullName,
                          dateOfBirth: user.dob,
                          address: user.address,
                          onTap: () => _navigateToDetail(context, user),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
        backgroundColor: const Color(0xFF1D4E9E),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, ManagedUser user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UserDetailPage(
          user: user,
          onDelete: () => _handleDelete(context, user),
          onUpdate: (updatedUser) => _handleUpdate(context, updatedUser),
        ),
      ),
    );
  }

  void _navigateToAdd(BuildContext context) async {
    final viewModel = context.read<UsersViewModels>();
    final result = await Navigator.of(context).push<ManagedUser>(
      MaterialPageRoute(
        builder: (_) => const UserFormPage(),
      ),
    );

    if (result != null && context.mounted) {
      await viewModel.add(result.fullName, result.dob, result.address);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thêm người dùng thành công'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _handleDelete(BuildContext context, ManagedUser user) async {
    final viewModel = context.read<UsersViewModels>();
    try {
      await viewModel.delete(user.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Xóa người dùng thành công'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleUpdate(BuildContext context, ManagedUser user) async {
    final viewModel = context.read<UsersViewModels>();
    try {
      await viewModel.update(user.id, user.fullName, user.dob, user.address);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật người dùng thành công'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

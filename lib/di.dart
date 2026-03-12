import 'package:mvvm_project/data/implementations/api/auth_api.dart';
import 'package:mvvm_project/data/implementations/local/app_database.dart';
import 'package:mvvm_project/data/implementations/mapper/auth_mapper.dart';
import 'package:mvvm_project/data/implementations/repositories/auth_repository.dart';
import 'package:mvvm_project/viewmodels/login/login_viewmodel.dart';
import 'package:mvvm_project/viewmodels/usermanagement/users_viewmodels.dart';
import 'data/implementations/api/managed_user_api.dart';
import 'data/implementations/mapper/managed_user_mapper.dart';
import 'data/implementations/repositories/managed_user_repository.dart';


LoginViewModel buildLoginVM(){
  // final authApi = AuthApi(); // implements AuthApi
  final authApi = AuthApi(AppDatabase.instance); // implements AuthApi
  final authSessionMapper = AuthSessionMapper(); // DTO =>Entity
  final authRepository = AuthRepository(api: authApi, mapper: authSessionMapper);// implements AuthRepository
  return LoginViewModel(repository: authRepository);
}


ManagedUserRepository buildManagedUserRepository(){
  final api = ManagedUserApi(AppDatabase.instance);
  final mapper = ManagedUserMapper();
  return ManagedUserRepository(api: api, mapper: mapper );
}

UsersViewModels buildUserViewModel(){
  return UsersViewModels(repo: buildManagedUserRepository());
}
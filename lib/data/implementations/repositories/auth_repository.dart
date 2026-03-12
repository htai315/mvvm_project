import 'package:mvvm_project/data/dtos/login/login_request_dto.dart';
import 'package:mvvm_project/data/dtos/login/login_response_dto.dart';
import 'package:mvvm_project/data/implementations/api/auth_api.dart';
import 'package:mvvm_project/data/interfaces/mapper/imapper.dart';
import 'package:mvvm_project/data/interfaces/repositories/iauth_repository.dart';
import 'package:mvvm_project/domain/entities/auth_session.dart';

class AuthRepository implements IAuthRepository{
  final AuthApi api;
  final IMapper<LoginResponseDto,AuthSession> mapper;

  AuthRepository({required this.api, required this.mapper});

  @override
  Future<AuthSession> login(String userName, String password) async{
    final request = LoginRequestDto(userName: userName, password: password);
    final response = await api.login(request);
    return mapper.map(response);
  }

  @override
  Future<AuthSession?> getCurrentSession() async{
    final dto = await api.getCurrentSession();
    if(dto == null) return null;
    return mapper.map(dto);
  }

  @override
  Future<void> logout() async{
    await api.logout();
  }
}






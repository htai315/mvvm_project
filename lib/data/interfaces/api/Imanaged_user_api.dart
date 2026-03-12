import '../../dtos/usermanagement/managed_user_dto.dart';
import '../../dtos/usermanagement/update_insert_user_request_dto.dart';

abstract class IMangedUserApi{
  Future<List<ManagedUserDto>> getAll();
  Future<ManagedUserDto?> getById(int id);
  Future<int> create(UpdateInsertUserRequestDto req);
  Future<int> update(int id,UpdateInsertUserRequestDto req);
  Future<int>  delete(int id);

  Future<void> seedDemoIfEmpty();
}
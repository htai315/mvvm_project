import '../../../domain/entities/managed_user.dart';
import '../../dtos/usermanagement/managed_user_dto.dart';
import '../../interfaces/mapper/imapper.dart';

class ManagedUserMapper implements IMapper<ManagedUserDto,ManagedUser>{
  @override
  ManagedUser map (ManagedUserDto input){
    return ManagedUser(
      id: input.id,
      fullName:  input.fullName,
      dob: input.dob,
      address: input.address,
      createdAt: input.createdAt,
    );
  }
}
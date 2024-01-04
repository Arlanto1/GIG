
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getKeyLossDestruction = '$baseUrl/getKemMgmtDestructiontList?';
}

class KeyLossDestructionListServices {

  Future<String> getUserEmail() async {
    String email =  await SharedPrefs.getEmail();
    return email;
  }

  Future<KeyLossDestructionListResponse> getList({
    required String startPosition,
    required String maximumRecords,
  }) async {
    String url =
        '${Apis._getKeyLossDestruction}startPos=$startPosition&maxResults=$maximumRecords';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return KeyLossDestructionListResponse.fromJson(response);
  }

}

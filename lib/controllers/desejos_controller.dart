// DesejosController
import 'package:get/get.dart';
import 'package:meu_app/controllers/my_home_page_controller.dart';
import 'package:meu_app/models/product_item.dart';
import 'package:meu_app/services/auth.dart';
import 'package:meu_app/services/productSave.dart';

class DesejosController extends GetxController {
  var desejos = <ProductItem>[].obs;
  final ProductSaveService productSaveService = ProductSaveService();
  final String userId = AuthService().getUserId();
  final MyHomePageController controller = Get.find<MyHomePageController>();

  @override
  void onInit() {
    super.onInit();
    loadDesejos();
    ever(controller.allproducts, (_) => loadDesejos()); // Escuta mudanças em produtos
  }

  Future<void> loadDesejos() async {
    try {
      List<String> favoriteProductIds = await productSaveService.obterProdutosFavoritados(userId);
      desejos.assignAll(controller.getProductsByIds(favoriteProductIds));
      update(); // Atualiza a interface quando a lista é alterada
    } catch (e) {
      print('Erro ao carregar desejos: $e');
    }
  }
}

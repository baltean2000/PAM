import 'package:get/get.dart';
import '../../data/repository.dart';
import '../../domain/models.dart';

class BarbershopController extends GetxController {
  final BarbershopRepository repository = BarbershopRepository();

  var nearestBarbershops = <Barbershop>[].obs;
  var mostRecommendedBarbershops = <Barbershop>[].obs;
  var popularChoices = <Barbershop>[].obs;
  var banner = Rx<AdBanner?>(null);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    banner.value = await repository.getBanner();
    nearestBarbershops.value = await repository.getNearestBarbershops();
    mostRecommendedBarbershops.value = await repository.getMostRecommendedBarbershops();
    popularChoices.value = await repository.getPopularChoices();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barbershop_controller.dart';
import '../domain/models.dart';

class BarbershopHomePage extends StatelessWidget {
  final BarbershopController controller = Get.put(BarbershopController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.nearestBarbershops.isEmpty || controller.banner.value == null) {
        return Scaffold(
          appBar: AppBar(title: Text('Barbershop Finder')),
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Barbershop Finder', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildBanner(controller.banner.value),
                _buildSearchBar(),
                _buildSection('Barbershop-uri in apropiere', controller.nearestBarbershops),
                _buildSection('Recomandari de TOP', controller.mostRecommendedBarbershops),
                _buildSection('Populare', controller.popularChoices),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/CrazyMonkey.png')),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Baltean Sergiu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('ManageEngine', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildBanner(AdBanner? bannerData) {
    if (bannerData == null) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(bannerData.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          child: Text(bannerData.buttonTitle, style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Cautare...',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildSection(String title, List<Barbershop> barbershops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: barbershops.length,
          itemBuilder: (context, index) {
            final shop = barbershops[index];
            return ListTile(
              leading: Image.asset(shop.image, width: 50, height: 50),
              title: Text(shop.name),
              subtitle: Text(shop.locationWithDistance),
              trailing: Text(shop.reviewRate.toString()),
            );
          },
        ),
      ],
    );
  }
}

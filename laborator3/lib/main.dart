import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(BarbershopApp());
}

class BarbershopController extends GetxController {
  // Definirea unui RxMap cu tipuri clare
  var jsonData = <String, dynamic>{}.obs;

  // Funcție pentru încărcarea datelor JSON
  Future<void> loadJsonData() async {
    String data = await rootBundle.loadString('assets/v2.json');
    jsonData.value = json.decode(data) as Map<String, dynamic>;
  }
}

class BarbershopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Barbershops',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BarbershopHomePage(),
    );
  }
}

class BarbershopHomePage extends StatelessWidget {
  final BarbershopController controller = Get.put(BarbershopController());

  BarbershopHomePage() {
    // Încărcarea datelor JSON la inițializare
    controller.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Verificăm dacă datele sunt încărcate
      if (controller.jsonData.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Barbershop Finder'),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Datele din JSON
      final Map<String, dynamic> jsonData = controller.jsonData;

      final List<dynamic> nearestBarbershops = jsonData['nearest_barbershop'] ?? [];
      final List<dynamic> mostRecommendedBarbershops = jsonData['most_recommended'] ?? [];
      final List<dynamic> popularChoices = jsonData['list'] ?? [];

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
                SizedBox(height: 20),
                _buildBanner(jsonData['banner']),
                SizedBox(height: 20),
                _buildSearchBar(),
                SizedBox(height: 20),
                _buildNearestBarbershopsSection(nearestBarbershops),
                SizedBox(height: 20),
                _buildMostRecommendedSection(mostRecommendedBarbershops),
                SizedBox(height: 20),
                _buildPopularChoicesSection(popularChoices),
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
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/CrazyMonkey.png'),
        ),
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

  Widget _buildBanner(Map<String, dynamic>? bannerData) {
    if (bannerData == null) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(bannerData['image'] ?? ''),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Action for booking now
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(bannerData['button_title'] ?? 'Booking Now', style: TextStyle(fontSize: 16, color: Colors.white)),
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

  Widget _buildNearestBarbershopsSection(List<dynamic> nearestBarbershops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Barbershop-uri in apropiere',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: nearestBarbershops.length,
          itemBuilder: (context, index) {
            final shop = nearestBarbershops[index];
            return ListTile(
              leading: Image.asset(shop['image'] ?? '', width: 50, height: 50),
              title: Text(shop['name'] ?? ''),
              subtitle: Text(shop['location_with_distance'] ?? ''),
              trailing: Text((shop['review_rate'] ?? '').toString()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMostRecommendedSection(List<dynamic> mostRecommendedBarbershops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recomandari de TOP',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mostRecommendedBarbershops.length,
            itemBuilder: (context, index) {
              final shop = mostRecommendedBarbershops[index];
              return _buildCarouselItem(shop);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(Map<String, dynamic> shop) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(shop['image'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(shop['name'] ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(shop['location_with_distance'] ?? '', style: TextStyle(fontSize: 14)),
          SizedBox(height: 5),
          Text('Rating: ${shop['review_rate']}', style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPopularChoicesSection(List<dynamic> popularChoices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Populare',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: popularChoices.length,
          itemBuilder: (context, index) {
            final shop = popularChoices[index];
            return ListTile(
              leading: Image.asset(shop['image'] ?? '', width: 50, height: 50),
              title: Text(shop['name'] ?? ''),
              subtitle: Text(shop['location_with_distance'] ?? ''),
              trailing: Text((shop['review_rate'] ?? '').toString()),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(BarbershopApp());
}

class BarbershopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbershops',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BarbershopHomePage(),
    );
  }
}

class BarbershopHomePage extends StatefulWidget {
  @override
  _BarbershopHomePageState createState() => _BarbershopHomePageState();
}

class _BarbershopHomePageState extends State<BarbershopHomePage> {
  final List<Map<String, String>> nearestBarbershops = [
    {
      'name': 'TOPGUN BarberShop',
      'location': '1.7 km',
      'rating': '4.9',
      'image': 'assets/topgun.png', // Unique image for each barbershop
    },
    {
      'name': 'SVOY BarberShop',
      'location': '2 km',
      'rating': '4.7',
      'image': 'assets/SVOY.png', // Unique image
    },
    {
      'name': 'MenClub Barbershop',
      'location': '2.2 km',
      'rating': '4.5',
      'image': 'assets/MenClub.png', // Unique image
    },
  ];

  final List<Map<String, String>> mostRecommendedBarbershops = [
    {
      'name': 'Black Panther BarberShop',
      'location': 'Str.Bucuresti 43',
      'rating': '5',
      'image': 'assets/BlackPanther.jpg', // Unique image
    },
    {
      'name': 'Garage BarberShop',
      'location': 'Str. Alba-Iulia 158',
      'rating': '4.9',
      'image': 'assets/Garage.jpg', // Unique image
    },
    {
      'name': 'Crazy Monkey Barber & Men Stuff',
      'location': 'Str.Mitropolit Gavriil Banulescu-Bodoni 29',
      'rating': '5.0',
      'image': 'assets/CrazyMonkey.png', // Unique image
    },
    {
      'name': 'Barberman - Haircut styling & massage',
      'location': 'Str.Vadul lui Voda 70/1',
      'rating': '4.8',
      'image': 'assets/Barberman.jpg', // Unique image
    },
  ];

  final List<Map<String, String>> popularChoices = [
    {
  'name': 'Crazy Monkey Barber & Men Stuff',
  'location': 'Str.Mitropolit Gavriil Banulescu-Bodoni 29',
  'rating': '5.0',
  'image': 'assets/CrazyMonkey.png', // Unique image
    },
    {
      'name': 'Uncle Pete Barbershop',
      'location': 'Str.Bucuresti 14',
      'rating': '5.0',
      'image': 'assets/UnclePete.png', // Unique image
    },
    {
      'name': 'Barber House',
      'location': 'Str.Valea Trandafirilor 20',
      'rating': '4.9',
      'image': 'assets/BarberHouse.png', // Unique image
    },
  ];

  int _currentPage = 0;
  PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
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
              _buildBanner(),
              SizedBox(height: 20),
              _buildSearchBar(),
              SizedBox(height: 20),
              _buildNearestBarbershopsSection(),
              SizedBox(height: 20),
              _buildMostRecommendedSection(),
              SizedBox(height: 20),
              _buildPopularChoicesSection(),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/banner.png'),
          fit: BoxFit.fill,
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
          child: Text('Booking Now', style: TextStyle(fontSize: 16, color: Colors.white)),
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

  Widget _buildNearestBarbershopsSection() {
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
              leading: Image.asset(shop['image']!, width: 50, height: 50),
              title: Text(shop['name']!),
              subtitle: Text(shop['location']!),
              trailing: Text(shop['rating']!),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMostRecommendedSection() {
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
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: mostRecommendedBarbershops.length,
            itemBuilder: (context, index) {
              final shop = mostRecommendedBarbershops[index];
              return _buildCarouselItem(shop);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mostRecommendedBarbershops.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _pageController.animateToPage(entry.key, duration: Duration(milliseconds: 300), curve: Curves.easeIn),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black).withOpacity(_currentPage == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(Map<String, String> shop) {
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
                  image: AssetImage(shop['image']!), // Use image from the shop data
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(shop['name']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(shop['location']!, style: TextStyle(fontSize: 14)),
          SizedBox(height: 5),
          Text('Rating: ${shop['rating']!}', style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPopularChoicesSection() {
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
              leading: Image.asset(shop['image']!, width: 50, height: 50),
              title: Text(shop['name']!),
              subtitle: Text(shop['location']!),
              trailing: Text(shop['rating']!),
            );
          },
        ),
      ],
    );
  }
}

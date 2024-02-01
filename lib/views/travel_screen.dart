import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/travel_descp.dart';
import '../models/travel_model.dart';

class TravelScreen extends StatefulWidget {
  TravelScreen({Key? key}) : super(key: key);

  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  String searchText = '';
  bool isSearchBarOpen = false;

  final List<TravelPlace> travelPlaces = [
    TravelPlace(
      name: 'Mersin Marina',
      description: TravelDescription.mersinMarina,
      image: "assets/images/places/marina.png",
      location: 'Mersin Marina, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Mersin Tarihi Taş Bina',
      description: TravelDescription.mersinTasBina,
      image: 'assets/images/places/tasbina.png',
      location: 'Tarihi Taş Bina, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Mersin Gilindire Mağarası',
      description: TravelDescription.mersinGlindere,
      image: 'assets/images/places/glindere.png',
      location: 'Gilindire Mağarası, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Mersin Mamure Kalesi',
      description: TravelDescription.mersinMamure,
      image: 'assets/images/places/mamure.png',
      location: ' Mamure Kalesi, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Mersin Cennet Cehennem',
      description: TravelDescription.mersinCennet,
      image: 'assets/images/places/cennet.png',
      location: 'Cennet Cehennem, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Mersin Alahan Manastırı',
      description: TravelDescription.mersinAlahan,
      image: 'assets/images/places/alahan.png',
      location: 'Alahan Manastırı, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Mersin Kız Kalesi',
      description: TravelDescription.mersinKizKulesi,
      image: 'assets/images/places/kale.png',
      location: 'Kız Kalesi, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Tarsus Şelalesi',
      description: TravelDescription.mersinTarsusSelale,
      image: 'assets/images/places/tarsus.png',
      location: 'Tarsus Şelalesi, Mersin', // Örnek bir konum bilgisi

    ),
    TravelPlace(
      name: 'Astım Mağarası',
      description: TravelDescription.mersinAstimMagara,
      image: 'assets/images/places/astim.png',
      location: 'Astım Mağarası, Mersin', // Örnek bir konum bilgisi

    ),
    // Diğer gezilecek yerleri ekleyebilirsiniz
  ];

  List<TravelPlace> getFilteredPlaces() {
    return travelPlaces.where((place) {
      return place.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<TravelPlace> filteredPlaces = getFilteredPlaces();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isSearchBarOpen
            ? TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Ara...',
          ),
        )
            : Text('Gezilecek Yerler'),
        actions: [
          IconButton(
            icon: Icon(isSearchBarOpen ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearchBarOpen = !isSearchBarOpen;
                searchText = '';
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredPlaces.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TravelPlaceDetailPage(
                    travelPlace: filteredPlaces[index],
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    filteredPlaces[index].image,
                    height: 200.0, // Özel bir yükseklik belirleyebilirsiniz
                    fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text(filteredPlaces[index].name),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(filteredPlaces[index].image),
                    ),
                    trailing: Icon(Icons.arrow_forward), // Üçgen icon ekleniyor
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TravelPlaceDetailPage extends StatelessWidget {
  final TravelPlace travelPlace;

  TravelPlaceDetailPage({required this.travelPlace});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(travelPlace.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(travelPlace.image),
              SizedBox(height: 16.0),
              Text(
                'Detaylar:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(travelPlace.description),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(left: 140,bottom: 30),
                child: InkWell(
                  onTap: () {
                    // Konum butonuna tıklandığında harita uygulamasını aç
                    _launchMap(travelPlace.location);
                  },
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.location_on, size: 75, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Harita uygulamasını açan fonksiyon
  _launchMap(String location) async {
    // Google Haritalar uygulamasını açmak için bir URL oluştur
    String mapUrl = 'https://www.google.com/maps/search/?api=1&query=$location';

    // URL'yi açmaya çalış
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      // Eğer açılamazsa hata mesajı göster
      throw 'Konum açılamıyor: $mapUrl';
    }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_weather_forecast/flutter_weather_forecast.dart';

import '../services/news_services.dart';

class HomeScreen extends StatelessWidget {
  final RssService rssService = RssService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veriler yükleniyor ise bir yükleniyor göstergesi göster
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Hata durumu
          return Scaffold(
            body: Center(
              child: Text('Hata oluştu: ${snapshot.error}'),
            ),
          );
        } else {
          // Veriler başarıyla geldi ise sayfayı oluştur
          List<Map<String, String>> items = snapshot.data as List<Map<String, String>>;

          return Scaffold(
            body: ListView(
              children: [
                WeatherForecast(
                  stationNo: '33',
                  containerHeight: MediaQuery.of(context).size.height * 0.18,
                  // Adjust the value as needed
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length + 1, // +1 ekledik, çünkü başlık ekleyeceğiz
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // İlk eleman başlık olacak
                        return Container(
                          padding: EdgeInsets.only(bottom: 10,left: 10),
                          child: Text(
                            'HABERLER',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(items[index - 1]['title'] ?? ''),
                          subtitle: Text(items[index - 1]['pubDate'] ?? ''),
                          onTap: () {
                            // Add navigation or other actions here
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, String>>> fetchData() async {
    final List<Map<String, String>> data = await rssService.fetchRssData();
    return data;
  }
}

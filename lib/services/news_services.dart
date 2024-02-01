import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class RssService {
  Future<List<Map<String, String>>> fetchRssData() async {
    final response =
    await http.get(Uri.parse('https://www.mersinblokhaber.com/rss.xml'));
    if (response.statusCode == 200) {
      final xmlDocument = xml.XmlDocument.parse(response.body);
      final itemsList = xmlDocument.findAllElements('item');

      return itemsList.map((item) {
        return {
          'title': item.findElements('title').first.text,
          'link': item.findElements('link').first.text,
          'description': item.findElements('description').first.text,
          'pubDate': item.findElements('pubDate').first.text,
          // Add more fields as needed
        };
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

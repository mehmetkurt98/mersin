import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher eklentisini eklemeyi unutmayın
import '../models/pharmacy_model.dart';
import '../services/pharmacy_services.dart';

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final PharmacyService _pharmacyService = PharmacyService();
  List<Pharmacy> _pharmacies = [];

  @override
  void initState() {
    super.initState();
    _loadPharmacies();
  }

  Future<void> _loadPharmacies() async {
    String ilce = "";
    String il = "Mersin";

    List<Pharmacy> pharmacies = await _pharmacyService.getDutyPharmacies(ilce, il);

    setState(() {
      _pharmacies = pharmacies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Duty Pharmacies"),
      ),
      body: _pharmacies.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _pharmacies.length,
        itemBuilder: (context, index) {
          Pharmacy pharmacy = _pharmacies[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(pharmacy.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pharmacy.address),
                  Text("Phone: ${pharmacy.phone}"),
                ],
              ),
              // Diğer bilgileri de gösterebilirsiniz
              onTap: () {
                // Eczane kartına tıklandığında yapılacak işlemler
                _launchPhoneCall(pharmacy.phone);
              },
            ),
          );
        },
      ),
    );
  }

  // Telefon numarasını aramak için kullanılan fonksiyon
  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Arama başlatılamadı: $url');
    }
  }
}

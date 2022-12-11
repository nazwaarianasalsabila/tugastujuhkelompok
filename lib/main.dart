import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:something/splash.dart';
import 'package:something/persediaan.dart';
import 'package:something/models/barang.dart';

import 'persediaan_provider.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) { 
    return ChangeNotifierProvider(
      create: (context) => StokProvider(),
      builder: (context, child) {
        return child!;
      },
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          

          if (snapshot.data!.getBool('login') == null) {
            snapshot.data!.setBool('login', false);
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.black,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.lime,
                foregroundColor: Colors.black,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.lime,
                foregroundColor: Colors.black,
              )
            ),
            home: snapshot.data!.getBool('login') == true ? HomeScreen() : const Splash(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Barang> listBarang = [
    Barang(
        name: 'Bandana',
        price: '20000',
        description:
            'Jenis aksesoris wanita yang ini sangat berguna untuk memperindah rambut kamu'),
    Barang(
        name: 'Kalung',
        price: '50000',
        description:
            'Kalung sebagai aksesoris agar penampilan makin elegan.'),
    Barang(
        name: 'Topi',
        price: '35000',
        description:
            'Topi bisa untuk melindungi kepala dan wajahmu dari panas matahari.'),
    Barang(
        name: 'Kacamata',
        price: '45000',
        description:
            'Kacamata hitam merupakan aksesoris wanita yang berfungsi untuk melindungi mata dari silau karena sinar matahari..'),
    Barang(
        name: 'Gelang',
        price: '25000',
        description:
            'Gelang menjadi aksesoris yang banyak digunakan sehingga penampilan jadi nggak flat.'),
    Barang(
        name: 'Jam Tangan',
        price: '125000',
        description:
            'Jam tangan membuat penampilanmu jadi makin stylish, dan juga berguna sebagai penunjuk waktu.'),
    Barang(
        name: 'Jepit Rambut',
        price: '25000',
        description:
            'Jepit rambut bisa mengubah look-mu jadi makin oke.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NaNa Shop'),
      ),
      body: ListView.builder(
        itemCount: listBarang.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listBarang[index].name),
            subtitle: Text('Rp. ${listBarang[index].price}'),
            onTap: () {},
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await context.read<StokProvider>().tambahBarang(listBarang[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const Stok();
              },
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

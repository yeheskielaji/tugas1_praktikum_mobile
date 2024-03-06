import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Barang',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> jumlahBarang = List.generate(100, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Stock Barang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.green,
          ),
        ),
      ),
      body: StockBarang(
          jumlahBarang: jumlahBarang,
          onJumlahBarangChanged: _updateJumlahBarang),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        child: BottomAppBar(
          color: const Color.fromARGB(255, 232, 232, 232),
          height: 50,
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Yeheskiel Pambuko Aji | 123210100',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateJumlahBarang(int index, int newValue) {
    setState(() {
      jumlahBarang[index] = newValue;
    });
  }
}

class Sembako {
  final String nama;
  final String imagePath;

  Sembako({
    required this.nama,
    required this.imagePath,
  });
}

class StockBarang extends StatelessWidget {
  final List<int> jumlahBarang;
  final Function(int index, int newValue) onJumlahBarangChanged;

  StockBarang({
    Key? key,
    required this.jumlahBarang,
    required this.onJumlahBarangChanged,
  }) : super(key: key);

  final List<Sembako> daftarSembako = [
    Sembako(nama: 'Beras', imagePath: 'assets/images/beras.png'),
    Sembako(nama: 'Bawang Merah', imagePath: 'assets/images/bawang_merah.png'),
    Sembako(nama: 'Bawang Putih', imagePath: 'assets/images/bawang_putih.png'),
    Sembako(
        nama: 'Cabai Keriting', imagePath: 'assets/images/cabai_keriting.png'),
    Sembako(nama: 'Cabai Rawit', imagePath: 'assets/images/cabai_rawit.png'),
    Sembako(nama: 'Telur', imagePath: 'assets/images/telur.png'),
    Sembako(
        nama: 'Tepung Terigu', imagePath: 'assets/images/tepung_terigu.png'),
    Sembako(nama: 'Gula', imagePath: 'assets/images/gula.png'),
    Sembako(
        nama: 'Minyak Goreng', imagePath: 'assets/images/minyak_goreng.png'),
    Sembako(nama: 'Masako', imagePath: 'assets/images/masako.png'),
    Sembako(nama: 'Kecap', imagePath: 'assets/images/kecap.png'),
    Sembako(nama: 'Saos', imagePath: 'assets/images/saos.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: daftarSembako.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(daftarSembako[index].imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                daftarSembako[index].nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Stock: ${jumlahBarang[index]}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(context, index);
                },
              ),
              onTap: () {
                print('${daftarSembako[index].nama} dipilih');
              },
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    int newValue = jumlahBarang[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Stock Barang'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Jumlah',
            ),
            onChanged: (value) {
              newValue = int.tryParse(value) ?? newValue;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                onJumlahBarangChanged(index, newValue);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}

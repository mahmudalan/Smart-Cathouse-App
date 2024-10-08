import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/realtime_db.dart';
import 'navbar.dart';

class KittenPage extends StatefulWidget {
  const KittenPage({super.key});

  @override
  State<KittenPage> createState() => _KittenPageState();
}

class _KittenPageState extends State<KittenPage> {
  dynamic nilaiSuhu;
  dynamic nilaiKelembaban;
  bool isManualMode = false;
  String statusKit = "Off";

  @override
  void initState() {
    dataSuhu.onValue.listen((event) {
      final getdataSuhu = event.snapshot;
      setState(() {
        nilaiSuhu = getdataSuhu.value;
      });
    });

    dataKelembaban.onValue.listen((event) {
      final getdataKelembaban = event.snapshot;
      setState(() {
        nilaiKelembaban = getdataKelembaban.value;
      });
    });

    super.initState();
  }

  Color creamMuda = const Color(0xffEEEDEB);
  Color creamTua = const Color(0xffE0CCBE);
  Color coklatMuda = const Color(0xff747264);
  Color coklatTua = const Color(0xff3C3633);

  // Method untuk mengubah modeKitten
  void toggleKittenMode(bool newValue) {
    setState(() {
      isManualMode = newValue;
      final modeCat = isManualMode ? 'Kitten' : 'Adult';
      dataModeCat.set(modeCat);
    });
  }

  void toggleManualKittenMode() {
    setState(() {
      if (statusKit == "On") {
        statusKit = "Off";
      } else {
        statusKit = "On";
      }
      dataStatusKit.set(statusKit);
    });
  }

  @override
  Widget build(BuildContext context) {
    String statusSuhu;
    String statusKelembaban;

    // Penyesuaian status suhu
    if (nilaiSuhu != null) {
      statusSuhu = nilaiSuhu <= 30 ? "Cool" : "Warm";
    } else {
      statusSuhu = "Loading";
    }

    // Penyesuaian status kelembaban
    if (nilaiKelembaban != null) {
      statusKelembaban = nilaiKelembaban <= 50 ? "Dry" : "Warm";
    } else {
      statusKelembaban = "Loading";
    }

    return Scaffold(
      backgroundColor: const Color(0xffEEEDEB),
      drawer: const NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
        title: Center(
          child: Text(
            'SMART CATHOUSE',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Paratha',
                color: coklatTua),
          ),
        ),
        backgroundColor: creamTua,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: coklatTua, borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Buddy!',
                        style: TextStyle(
                            color: creamTua,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'UnigeoMedium'),
                      ),
                      Text(
                        'Welcome to',
                        style: TextStyle(
                            color: creamTua,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'UnigeoMedium'),
                      ),
                      Text(
                        'Kitten Mode',
                        style: TextStyle(
                            color: creamTua,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'UnigeoMedium'),
                      ),
                      Text(
                        'Cathouse',
                        style: TextStyle(
                            color: coklatMuda,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'UnigeoMedium',
                            fontSize: 30),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'lib/assets/kitty.png',
                        height: 100,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Kitten Mode Dashboard',
                  style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    DateFormat('dd/MM/yy').format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'AgencyFB',
                      color: Color(0xff3C3633),
                    ),
                  ),
                  const SizedBox(width: 10),
                  StreamBuilder<DateTime>(
                    stream: Stream.periodic(
                        const Duration(seconds: 1), (i) => DateTime.now()),
                    builder: (context, snapshot) {
                      return Text(
                        DateFormat('HH:mm').format(snapshot.data ?? DateTime.now()),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'AgencyFB',
                          color: Color(0xff3C3633),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: 157.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: creamTua, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Temperature :',
                          style: TextStyle(
                              color: coklatTua,
                              fontFamily: 'UnigeoMedium',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          '$nilaiSuhu° C',
                          style: TextStyle(
                              color: coklatMuda,
                              fontFamily: 'AgencyFB',
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                        Text(
                          'Current Status :',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium', color: coklatTua),
                        ),
                        Text(
                          statusSuhu,
                          style: TextStyle(
                              color: coklatTua,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AgencyFB',
                              fontSize: 25),
                        ),
                        const SizedBox(height: 5,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    width: 157.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: creamTua, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Humidity :',
                          style: TextStyle(
                              color: coklatTua,
                              fontFamily: 'UnigeoMedium',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          '$nilaiKelembaban %',
                          style: TextStyle(
                              color: coklatMuda,
                              fontFamily: 'AgencyFB',
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                        Text(
                          'Current Status',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium', color: coklatTua),
                        ),
                        Text(
                          statusKelembaban,
                          style: TextStyle(
                              color: coklatTua,
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: 157.5,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: creamTua, width: 2)),
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        Text(
                          'Lamp',
                          style: TextStyle(
                              color: coklatTua,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'UnigeoMedium'),
                        ),
                        const SizedBox(height: 25,),
                        Image.asset('lib/assets/lightON.png',height: 100,),
                        const SizedBox(height: 25,),
                        Text(
                          'Set to',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium', color: coklatTua),
                        ),
                        Text(
                          'Always On',
                          style: TextStyle(
                              color: coklatTua,
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    width: 157.5,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: creamTua, width: 2)),
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        Text(
                          'Fan',
                          style: TextStyle(
                              color: coklatTua,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'UnigeoMedium'),
                        ),
                        const SizedBox(height: 25,),
                        Image.asset('lib/assets/fan.png',height: 100,),
                        const SizedBox(height: 25,),
                        Text(
                          'Set to',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium', color: coklatTua),
                        ),
                        Text(
                          'Always On',
                          style: TextStyle(
                              color: coklatTua,
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cat Mode:',
                        style: TextStyle(
                          fontFamily: 'UnigeoMedium',
                          fontSize: 18,
                          color: Color(0xff3C3633),
                        ),
                      ),
                      Switch(
                        value: isManualMode,
                        onChanged: toggleKittenMode,
                        activeColor: coklatTua,
                        inactiveThumbColor: coklatMuda,
                      ),
                      Text(
                        isManualMode ? "Kitten" : "Adult Cat",
                        style: const TextStyle(
                          fontFamily: 'UnigeoMedium',
                          fontSize: 18,
                          color: Color(0xff3C3633),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: isManualMode ? toggleManualKittenMode : null,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 80),
                      backgroundColor: statusKit == "On" ? coklatMuda : coklatTua,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      statusKit == "On" ? "Turn Off Kitten Mode" : "Turn On Kitten Mode",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

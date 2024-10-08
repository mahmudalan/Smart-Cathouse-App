import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../services/realtime_db.dart';

class Cathouse extends StatefulWidget {
  const Cathouse({super.key});

  @override
  State<Cathouse> createState() => _CathouseState();
}

class _CathouseState extends State<Cathouse> {
  dynamic nilaiSuhu;
  dynamic nilaiKelembaban;
  dynamic nilaiJarak;
  @override
  void initState() {
    super.initState();

    dataJarak.onValue.listen((event) {
      final getdataJarak = event.snapshot;
      setState(() {
        nilaiJarak = getdataJarak.value;
      });
    });

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
  }

  @override
  Widget build(BuildContext context) {
    Color cream = const Color(0xffE0CCBE);
    Color darkcream = const Color(0xff747264);
    Color coklat = const Color(0xff3C3633);
    String statusJarak;
    String statusSuhu;
    String statusLampu;
    String statusKipas;
    String statusKelembaban;
    String gambarlampu;
    String gambarkipas;
    Color colorsuhu;
    Color colorkelembaban;
    if (nilaiSuhu != null && nilaiKelembaban != null && nilaiJarak != null){
      if (nilaiJarak <= 30){
        statusJarak = "There's a Cat";
      } else {
        statusJarak = 'No Cat';
      }

      if (nilaiSuhu < 30 ){
        statusSuhu = 'Cool';
        gambarlampu = 'lib/assets/lightON.png';
        statusLampu = 'Lamp is On';
        colorsuhu = Colors.lightBlueAccent;
      } else if (nilaiSuhu >= 30 && nilaiSuhu<=35){
        statusSuhu = 'Ideal';
        gambarlampu = 'lib/assets/lightON.png';
        statusLampu = 'Lamp is On';
        colorsuhu = Colors.green;
      } else {
        statusSuhu = 'Hot';
        gambarlampu = 'lib/assets/lightOFF.png';
        statusLampu = 'Lamp is Off';
        colorsuhu = Colors.red;
      }

      if (nilaiKelembaban < 60){
        statusKelembaban = 'Dry';
        gambarkipas = 'lib/assets/fan off.png';
        statusKipas = 'Fan is Off';
        colorkelembaban = coklat;
      } else {
        statusKelembaban = 'Humid';
        gambarkipas = 'lib/assets/fan on.png';
        statusKipas = 'Fan is On';
        colorkelembaban = Colors.lightBlue;
      }
    } else {
      statusSuhu = 'Loading Data';
      statusKelembaban = 'Loading Data';
      gambarkipas = 'lib/assets/loading.png';
      gambarlampu = 'lib/assets/loading.png';
      statusJarak = 'Loading Data';
      statusLampu = 'Loading';
      statusKipas = 'Loading';
      colorsuhu = coklat;
      colorkelembaban = coklat;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: coklat,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Buddy!',
                      style: TextStyle(
                        color: cream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: cream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Cathouse',
                      style: TextStyle(
                        color: darkcream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Lottie.asset('lib/assets/cat1.json', height: 110),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Catroom Dashboard',
                  style: TextStyle(
                    color: coklat,
                    fontFamily: 'UnigeoMedium',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AgencyFB',
                    color: coklat,
                  ),
                ),
                const SizedBox(width: 10),
                StreamBuilder<DateTime>(
                  stream: Stream.periodic(
                      const Duration(seconds: 1), (i) => DateTime.now()),
                  builder: (context, snapshot) {
                    return Text(
                      DateFormat('HH:mm')
                          .format(snapshot.data ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'AgencyFB',
                        color: coklat,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cream, width: 2)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Status:',style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                      ),
                    ),
                    Text(statusJarak,
                      style: TextStyle(
                      color: darkcream,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Distance:',
                      style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                      ),
                    ),
                    Text('$nilaiJarak cm',
                      style: TextStyle(
                        color: darkcream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AgencyFB',
                        fontSize: 30,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cream, width: 2)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Current', style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                      ),
                    ),
                    Text('Temperature:', style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                    const SizedBox(height: 20,),
                    Text('$nilaiSuhu°C', style: TextStyle(
                      color: colorsuhu,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AgencyFB',
                      fontSize: 50,
                    ),
                    ),
                    const SizedBox(height: 20,),
                    Text(statusSuhu, style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Lamp Status:', style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                    const SizedBox(height: 10,),
                    Image.asset(gambarlampu, height: 100,),
                    const SizedBox(height: 10,),
                    Text(statusLampu,style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),)
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cream, width: 2)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Fan Status:', style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                    const SizedBox(height: 10,),
                    Image.asset(gambarkipas, height: 100,),
                    const SizedBox(height: 10,),
                    Text(statusKipas,style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),)
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Current', style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                    Text('Humidity:', style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                    const SizedBox(height: 20,),
                    Text('$nilaiKelembaban %', style: TextStyle(
                      color: colorkelembaban,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AgencyFB',
                      fontSize: 50,
                    ),
                    ),
                    const SizedBox(height: 20,),
                    Text(statusKelembaban, style: TextStyle(
                      color: coklat,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UnigeoMedium',
                      fontSize: 16,
                    ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


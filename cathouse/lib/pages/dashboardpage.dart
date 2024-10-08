import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../services/realtime_db.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  dynamic nilaiSuhu;
  String fahrenheit ='';
  String kelvin ='';
  String reamur ='';
  dynamic nilaiKelembaban;

  @override
  void initState() {
    super.initState();
    dataSuhu.onValue.listen((event) {
      final getdataSuhu = event.snapshot;
      setState(() {
        nilaiSuhu = getdataSuhu.value;
        fahrenheit = (((9 * nilaiSuhu) / 5) + 32).toStringAsFixed(2);
        kelvin = (nilaiSuhu + 273).toStringAsFixed(2);
        reamur = ((4 * nilaiSuhu) / 5).toStringAsFixed(2);
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
    String statusSuhu;
    String statusKelembaban;
    Color colorsuhu;
    Color colorkelembaban;
    String animationFile;
    String animationFileHumidity;

    if (nilaiSuhu != null && nilaiKelembaban != null) {
      if (nilaiSuhu < 30) {
        statusSuhu = 'Cool';
        colorsuhu = Colors.lightBlueAccent;
        animationFile = 'lib/assets/cool.json';
      } else if (nilaiSuhu >= 30 && nilaiSuhu <= 35) {
        animationFile = 'lib/assets/hot.json';
        statusSuhu = 'Ideal';
        colorsuhu = Colors.green;
      } else {
        statusSuhu = 'Hot';
        colorsuhu = Colors.red;
        animationFile = 'lib/assets/hot.json';
      }

      if (nilaiKelembaban < 60) {
        statusKelembaban = 'Dry';
        colorkelembaban = coklat;
        animationFileHumidity = 'lib/assets/dry.json';
      } else {
        statusKelembaban = 'Humid';
        colorkelembaban = Colors.lightBlue;
        animationFileHumidity = 'lib/assets/wet.json';
      }
    } else {
      statusSuhu = 'Loading Data';
      statusKelembaban = 'Loading Data';
      colorsuhu = coklat;
      colorkelembaban = coklat;
      animationFile = 'lib/assets/loading.json';
      animationFileHumidity = 'lib/assets/loading.json';
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
                  'Main Dashboard',
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
            decoration: BoxDecoration(
              border: Border.all(color: cream, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('lib/assets/cat2.json', height: 100),
                Column(
                  children: [
                    Text(
                      'Welcome to Temperature',
                      style: TextStyle(
                        fontFamily: 'UnigeoMedium',
                        color: darkcream,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '& Humidity dashboard',
                      style: TextStyle(
                        fontFamily: 'UnigeoMedium',
                        color: darkcream,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Smart Cathouse.',
                      style: TextStyle(
                        fontFamily: 'UnigeoMedium',
                        color: darkcream,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Enjoy your day, Sir.',
                      style: TextStyle(
                        fontFamily: 'UnigeoMedium',
                        color: darkcream,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cream, width: 2),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Current',
                          style: TextStyle(
                            color: coklat,
                            fontFamily: 'UnigeoMedium',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Temperature',
                          style: TextStyle(
                            color: coklat,
                            fontFamily: 'UnigeoMedium',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$nilaiSuhu °C',
                          style: TextStyle(
                            color: colorsuhu,
                            fontFamily: 'AgencyFB',
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Current Status:',
                          style: TextStyle(
                            color: coklat,
                            fontFamily: 'UnigeoMedium',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          statusSuhu,
                          style: TextStyle(
                            color: colorsuhu,
                            fontFamily: 'UnigeoMedium',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Lottie.asset(animationFile, height: 150)
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cream, width: 2),
                  ),
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Fahrenheit:',
                            style: TextStyle(
                                color: coklat,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'UnigeoMedium'),
                          ),
                          Text('$fahrenheit °F',
                            style: TextStyle(
                              color: darkcream,
                              fontSize: 20,
                              fontFamily: 'AgencyFB'),)
                        ],
                      ),
                      Column(
                        children: [
                          Text('Reamur:',
                              style: TextStyle(
                                  color: coklat,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'UnigeoMedium')),
                          Text('$reamur °R',
                            style: TextStyle(
                                color: darkcream,
                                fontSize: 20,
                                fontFamily: 'AgencyFB'),)
                        ],
                      ),
                      Column(
                        children: [
                          Text('Kelvin:',
                              style: TextStyle(
                                  color: coklat,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'UnigeoMedium')),
                          Text('$kelvin °K',
                            style: TextStyle(
                                color: darkcream,
                                fontSize: 20,

                                fontFamily: 'AgencyFB'),)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: cream, width: 2),
            ),
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Current',
                      style: TextStyle(
                        color: coklat,
                        fontFamily: 'UnigeoMedium',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Humidity',
                      style: TextStyle(
                        color: coklat,
                        fontFamily: 'UnigeoMedium',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$nilaiKelembaban%',
                      style: TextStyle(
                        color: colorkelembaban,
                        fontFamily: 'AgencyFB',
                        fontWeight: FontWeight.bold,
                        fontSize: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Current Status:',
                      style: TextStyle(
                        color: coklat,
                        fontFamily: 'UnigeoMedium',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      statusKelembaban,
                      style: TextStyle(
                        color: colorkelembaban,
                        fontFamily: 'UnigeoMedium',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                Lottie.asset(animationFileHumidity, height: 150)
              ],
            ),
          ),

        ],
      ),
    );
  }
}

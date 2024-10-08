import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/realtime_db.dart';

class Chartpage extends StatefulWidget {
  const Chartpage({super.key});

  @override
  State<Chartpage> createState() => _ChartpageState();
}

class _ChartpageState extends State<Chartpage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  dynamic nilaiSuhu;
  dynamic nilaiKelembaban;
  List<FlSpot> TemperatureData = [];
  List<FlSpot> HumidityData = [];
  final int dataLimit = 24;
  List<String> timeLabels = [];
  bool isDataLoaded = false;

  double avgTemp = 0;
  double minTemp = 0;
  double maxTemp = 0;
  double avgHumidity = 0;
  double minHumidity = 0;
  double maxHumidity = 0;


  @override
  void initState() {
    super.initState();
    _loadTemperatureData();
    _loadHumidityData();

    dataSuhu.onValue.listen((event) {
      final getdataSuhu = event.snapshot;
      setState(() {
        nilaiSuhu = getdataSuhu.value;
        _updateTemperatureData();
        _calculateTemperatureStats();
      });
    });

    dataKelembaban.onValue.listen((event) {
      final getdataKelembaban = event.snapshot;
      setState(() {
        nilaiKelembaban = getdataKelembaban.value;
        _updateHumidityData();
        _calculateHumidityStats();
      });
    });

    // Reset data setiap tengah malam
    Timer.periodic(const Duration(hours: 1), (timer) {
      if (DateTime.now().hour == 0) {
        _resetData();
      }
    });
  }

  void _updateTemperatureData() {
    if (nilaiSuhu != null) {
      if (TemperatureData.length == dataLimit) {
        TemperatureData.removeAt(0);
        timeLabels.removeAt(0);
      }
      final currentTime = DateTime.now();
      TemperatureData.add(FlSpot(currentTime.hour + currentTime.minute / 60.0, double.parse(nilaiSuhu.toString())));
      timeLabels.add(DateFormat('HH:mm').format(currentTime));
      _saveTemperatureData();
    }
  }

  void _updateHumidityData() {
    if (nilaiKelembaban != null) {
      if (HumidityData.length == dataLimit) {
        HumidityData.removeAt(0);
      }
      final currentTime = DateTime.now();
      HumidityData.add(FlSpot(currentTime.hour + currentTime.minute / 60.0, double.parse(nilaiKelembaban.toString())));
      _saveHumidityData();
    }
  }

  void _saveTemperatureData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = TemperatureData.map((spot) => jsonEncode({'x': spot.x, 'y': spot.y})).toList();
    await prefs.setStringList('TemperatureData', dataList);
    await prefs.setStringList('timeLabels', timeLabels);
    await prefs.setString('lastSavedDate', DateFormat('yyyy-MM-dd').format(DateTime.now()));
    print('Temperature data saved: $dataList');
  }

  void _saveHumidityData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = HumidityData.map((spot) => jsonEncode({'x': spot.x, 'y': spot.y})).toList();
    await prefs.setStringList('HumidityData', dataList);
    await prefs.setStringList('timeLabels', timeLabels);
    await prefs.setString('lastSavedDate', DateFormat('yyyy-MM-dd').format(DateTime.now()));
    print('Humidity data saved: $dataList');
  }

  void _loadTemperatureData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('TemperatureData');
    List<String>? timeList = prefs.getStringList('timeLabels');
    String? lastSavedDate = prefs.getString('lastSavedDate');

    print('Loaded data: $dataList');
    print('Loaded time labels: $timeList');
    print('Last saved date: $lastSavedDate');

    if (dataList != null && timeList != null && lastSavedDate != null) {
      DateTime lastDate = DateFormat('yyyy-MM-dd').parse(lastSavedDate);
      DateTime currentDate = DateTime.now();
      // Buat objek DateTime yang hanya mencakup tahun, bulan, dan hari
      DateTime currentDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);

      // Periksa apakah tanggal terakhir berbeda dengan tanggal saat ini
      if (lastDate.isBefore(currentDateOnly)) {
        print('Different day detected. Data reset');
        _resetData();
      } else {
        setState(() {
          TemperatureData = dataList.map((data) {
            Map<String, dynamic> dataMap = jsonDecode(data);
            return FlSpot(dataMap['x'], dataMap['y']);
          }).toList();
          timeLabels = List<String>.from(timeList);
          isDataLoaded = true;
          _calculateTemperatureStats();
        });
        print('Temperature data loaded: $TemperatureData');
      }
    } else {
      // Tidak ada data yang disimpan, tidak perlu mereset
      setState(() {
        isDataLoaded = true;
      });
    }
  }
  void _loadHumidityData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('HumidityData');
    List<String>? timeList = prefs.getStringList('timeLabels');
    String? lastSavedDate = prefs.getString('lastSavedDate');

    print('Loaded data: $dataList');
    print('Loaded time labels: $timeList');
    print('Last saved date: $lastSavedDate');

    if (dataList != null && timeList != null && lastSavedDate != null) {
      DateTime lastDate = DateFormat('yyyy-MM-dd').parse(lastSavedDate);
      DateTime currentDate = DateTime.now();
      // Buat objek DateTime yang hanya mencakup tahun, bulan, dan hari
      DateTime currentDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);

      // Periksa apakah tanggal terakhir berbeda dengan tanggal saat ini
      if (lastDate.isBefore(currentDateOnly)) {
        print('Different day detected. Data reset');
        _resetData();
      } else {
        setState(() {
          HumidityData = dataList.map((data) {
            Map<String, dynamic> dataMap = jsonDecode(data);
            return FlSpot(dataMap['x'], dataMap['y']);
          }).toList();
          timeLabels = List<String>.from(timeList);
          isDataLoaded = true;
          _calculateHumidityStats();
        });
        print('Humidity data loaded: $HumidityData');
      }
    } else {
      // Tidak ada data yang disimpan, tidak perlu mereset
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  void _resetData() async {
    setState(() {
      TemperatureData.clear();
      HumidityData.clear();
      timeLabels.clear();
    });
    _saveTemperatureData();
    _saveHumidityData();
    setState(() {
      isDataLoaded = true;
    });
    print('Data reset');
  }

  void _calculateTemperatureStats() {
    if (TemperatureData.isNotEmpty) {
      double sum = TemperatureData.fold(0, (prev, element) => prev + element.y);
      avgTemp = sum / TemperatureData.length;
      minTemp = TemperatureData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
      maxTemp = TemperatureData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    } else {
      avgTemp = 0;
      minTemp = 0;
      maxTemp = 0;
    }
  }

  void _calculateHumidityStats() {
    if (HumidityData.isNotEmpty) {
      double sum = HumidityData.fold(0, (prev, element) => prev + element.y);
      avgHumidity = sum / HumidityData.length;
      minHumidity = HumidityData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
      maxHumidity = HumidityData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    } else {
      avgHumidity = 0;
      minHumidity = 0;
      maxHumidity = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Color cream = const Color(0xffE0CCBE);
    Color coklat = const Color(0xff3C3633);
    Color suhuColor = Colors.orange;
    Color kelembabanColor = Colors.blue;

    return isDataLoaded
        ? SingleChildScrollView(
      child: Column(
        children: [
            Container(
            height: 340,
            decoration: BoxDecoration(
              color: coklat,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: cream),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: LineChart(
              LineChartData(
                maxY: 100,
                minY: 0,
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      'Time',
                      style: TextStyle(color: cream, fontFamily: 'Balance'),
                    ),
                    sideTitles: const SideTitles(
                      showTitles: false,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: TextStyle(
                              color: cream,
                              fontFamily: 'Balance',
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    axisNameWidget: Text(
                      'DHT11 Sensor Monitor',
                      style: TextStyle(color: cream, fontFamily: 'Balance'),
                    ),
                    sideTitles: const SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    axisNameWidget: Text(
                      'Value',
                      style: TextStyle(color: cream, fontFamily: 'Balance'),
                    ),
                    sideTitles: const SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(color: cream),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: TemperatureData,
                    isCurved: false,
                    barWidth: 3,
                    color: suhuColor,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          suhuColor.withOpacity(0.4),
                          suhuColor.withOpacity(0.01),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: HumidityData,
                    isCurved: false,
                    barWidth: 3,
                    color: kelembabanColor,
                    belowBarData: BarAreaData(
                      gradient: LinearGradient(
                        colors: [
                          kelembabanColor.withOpacity(0.2),
                          kelembabanColor.withOpacity(0.01),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      show: true,
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.all(8),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final index = touchedSpot.spotIndex;
                        final value = touchedSpot.y;
                        final time = timeLabels[index];
                        return LineTooltipItem(
                          '$value\n$time',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 20,
                height: 10,
                color: suhuColor,
              ),
              const Text('Temperature (°C)', style: TextStyle(fontFamily: 'UnigeoMedium', fontSize: 14),),
              const SizedBox(width: 20),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 20,
                height: 10,
                color: kelembabanColor,
              ),
              const Text('Humidity (%)', style: TextStyle(fontFamily: 'UnigeoMedium', fontSize: 14),),
            ],
          ),
          Container(
            height: 245,
            decoration: BoxDecoration(
              border: Border.all(color: cream, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 10,),
                const Text('Data Sensor Statistics', style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'UnigeoMedium',
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'AgencyFB',
                    color: coklat,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Avg.',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        Text(
                          'Temperature',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          '${avgTemp.toStringAsFixed(2)}°C', // Nilai rata-rata suhu
                          style: TextStyle(
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              color: coklat),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Min.',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        Text(
                          'Temperature',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          '${minTemp.toStringAsFixed(2)}°C', // Nilai minimum suhu
                          style: TextStyle(
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              color: coklat),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Max.',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        Text(
                          'Temperature',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          '${maxTemp.toStringAsFixed(2)}°C', // Nilai maksimum suhu
                          style: TextStyle(
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              color: coklat),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: cream,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Avg.',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          '${avgHumidity.toStringAsFixed(2)}%', // Nilai rata-rata kelembaban
                          style: TextStyle(
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              color: coklat),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Min.',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          '${minHumidity.toStringAsFixed(2)}%', // Nilai minimum kelembaban
                          style: TextStyle(
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              color: coklat),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Max.',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(
                              fontFamily: 'UnigeoMedium',
                              fontSize: 16,
                              color: coklat),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          '${maxHumidity.toStringAsFixed(2)}%', // Nilai maksimum kelembaban
                          style: TextStyle(
                              fontFamily: 'AgencyFB',
                              fontSize: 25,
                              color: coklat),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    )
        : const Center(child: CircularProgressIndicator());
  }
}
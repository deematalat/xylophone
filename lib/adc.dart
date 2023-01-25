import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';

class Paino extends StatefulWidget {
  @override
  State<Paino> createState() => _PainoState();
}

class _PainoState extends State<Paino> {

  var path='assets/Best of Guitars-4U-v1.0.sf2';
  void load (String asset) async {
    FlutterMidi().unmute(); // Optionally Unmute
    ByteData _byte = await rootBundle.load(asset);
    FlutterMidi().prepare(sf2: _byte);
  }
  @override
  void initState() {
    load(path);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paino Game',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(icon: Icon(Icons.phone), onPressed: () {
          _launchUrl;

        },),
        actions: [
          DropdownButton(
            value: path,
            items:<DropdownMenuItem<dynamic>>[
              DropdownMenuItem(child:Text("paino"),value:'assets/Best of Guitars-4U-v1.0.sf2',),
              DropdownMenuItem(child:Text("quiter"),value:'assets/Yamaha-Grand-Lite-SF-v1.1.sf2'),
              DropdownMenuItem(child:Text("flute"),value:'assets/Expressive Flute SSO-v1.2.sf2'),
            ], onChanged: (value) {
            setState(() {
              path=value;
            });
          } ,

          ),
          IconButton(onPressed:(){
            _determinePosition;
          }, icon:Icon(Icons.gps_fixed_sharp))
        ],
      ),
      body: Center(
        child: InteractivePiano(
          highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
          naturalColor: Colors.white,
          accidentalColor: Colors.black,
          keyWidth: 60,
          noteRange: NoteRange.forClefs([
            Clef.Treble,
          ]),
          onNotePositionTapped: (position) {
            FlutterMidi().stopMidiNote(midi:position.pitch);
          },
        ),
      ),
    );
  }
}
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
final Uri phoneLaunchUri = Uri(
  scheme: 'tel',
  path: '+0592685916',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Example Subject & Symbols are allowed!',
  }),
);
Future<void> _launchUrl() async {
  if (!await launchUrl(phoneLaunchUri)) {
    throw 'Could not launch $phoneLaunchUri';
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/Controllers/firebase_storage_controller.dart';

class ProfileOverview extends StatefulWidget {
  const ProfileOverview({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<ProfileOverview> createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview> {
  FileInfo? file;

  getprofilepicture() async {
    file = await DefaultCacheManager().getFileFromCache(widget.url);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getprofilepicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'Profile photo',
          style: GoogleFonts.sourceSansPro(
            textStyle: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await FireBaseStorageController().addprofileimage(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: file == null
            ? const CircularProgressIndicator()
            : Image.file(file!.file),
      ),
    );
  }
}

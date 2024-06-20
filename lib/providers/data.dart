import 'package:calendar/helper/db_helper.dart';
import 'package:calendar/settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Data with ChangeNotifier {
  final Map<String, List> _allEvents = <String, List>{};
  Map<String, List> get allEvents => _allEvents;
  final List _allHadees = [
    "(سُبْحَانَ اللهِ وَبِحَمْدِهِ)، (سُبْحانَ اللهِ الْعَظِيمِ):كَلِمَتَانِ خَفِيفَتَانِ عَلَى اللِّسَانِ، ثَقِيلَتَانِ فِي الْمِيزَانِ، حَبِيبَتَانِ إِلَى الرَّحْمَنِ\nThere are two words which are light on the tongue, heavy on the scale, and loved by the Most Merciful: SubhanAllahi wa bihamdi, SubhanAllahi al-azeem (Glorified is Allah and praised is He, Glorified is Allah the Most Great). ",
    'جَاءَ رَجُلٌ إِلَى رَسُولِ اللهِ صلى الله عليه وسلم فَقَالَ يَا رَسُولَ اللهِ مَنْ أَحَقُّ بِحُسْنِ صَحَابَتِي قَالَ ‏”‏ أُمُّكَ ‏”‏‏.‏ قَالَ ثُمَّ مَنْ قَالَ ‏”‏ أُمُّكَ ‏”‏‏.‏ قَالَ ثُمَّ مَنْ قَالَ ‏”‏ أُمُّكَ ‏”‏‏.‏ قَالَ ثُمَّ مَنْ قَالَ ‏”‏ ثُمَّ أَبُوكَ‏”.‏‏‏\nA man came to the Messenger of Allah (ﷺ) and said, “O Messenger of Allah! Who among the people has the most right to my good company?” He replied, “Your mother.” The man said, “Then who?” He replied, “Your mother.” The man said, “Then who?” He replied, “Your mother.” The man said, “Then who?” He replied, “Then your father.”',
    "إِنَّ الْعَبْدَ لَيَتَكَلَّمُ بِالْكَلِمَةِ مَا يَتَبَيَّنُ فِيهَا، يَزِلُّ بِهَا فِي النَّارِ أَبْعَدَ مِمَّا بَيْنَ الْمَشْرِقِ وَ الْمَغْرِبِ\nA slave [of Allah] may utter a word without giving it much thought by which he slips into the fire a distance further than that between east and west.",
    "إِنَّ اللَّهَ يَغَارُ وَغَيْرَةُ اللهِ أَنْ يَأْتِيَ الْمُؤْمِنُ مَا حَرَّمَ اللهُ\nAllah becomes jealous [of His honor] and that is when the believer does something He has forbidden.",
    "مَنْ قَامَ رَمَضَانَ إِيمَانًا وَاحْتِسَابًا, غُفِرَ لَهُ مَا تَقَدَّمَ مِنْ ذَنْبِهِ\nWhoever stands [for night prayer] in Ramadan out of faith and hope for reward will be forgiven his past sins."

  ];
  List get allHadees => _allHadees;
  List events = [];

  Map<String, dynamic>? calenderTopAd;
  Map<String, dynamic>? calenderBottomAd;

  Map<String, dynamic>? hadeesTopAd;

  Map<String, dynamic>? hadeesBottomAd;

  void setevent(DateTime dateTime) {
    String fmDate = DateFormat('yyyy-MM-dd').format(dateTime);
    final le = _allEvents[fmDate];
    if (le == null) {
      events = [];
    } else {
      events = le;
    }
    notifyListeners();
  }

  // 1st function

  Future<void> loadFromOnline() async {
    //working with local events

    final List<Map<String, dynamic>> dbLocalEvents =
        await DBHelper.getLocalEvents();
    for (var event in dbLocalEvents) {
      String dt = event["date"];
      String ev = event["event"];
      if (_allEvents[dt] == null) {
        _allEvents[dt] = [ev];
      } else {
        _allEvents[dt]?.add(ev);
      }
    }

    //loading data from online
    print("Loading data from online");

    final url = "${Settings.apiUrl}/data";
    final response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body);
    final loadedEvents = responseData["events"] as List;
    final loadedHadees = responseData["hadees"] as List;
    final loadedAds = responseData["ads"] as List;

    //working with events

    for (var event in loadedEvents) {
      String dt = event["date"];
      String ev = event["title"];
      if (_allEvents[dt] == null) {
        _allEvents[dt] = [ev];
      } else {
        _allEvents[dt]?.add(ev);
      }
    }

    //delete old events

    await DBHelper.deleteEvents();

    //store locally
    _allEvents.forEach((date, events) async {
      for (var event in events) {
        await DBHelper.insertEvent(date, event);
      }
    });

    //woking with hadees

    for (var hadees in loadedHadees) {
      String h = hadees["hadees"];
      _allHadees.add(h);
    }

    //delete old hadees

    await DBHelper.deleteHadees();

    //store locally
    for (var hadees in _allHadees) {
      await DBHelper.insertHadees(hadees);
    }

    //working with hadees

    final prefs = await SharedPreferences.getInstance();

    for (var ad in loadedAds) {
      int id = ad["id"];
      if (id == 1) {
        calenderTopAd = {
          "image": ad["image"],
          "link": ad["link"],
          "active": true,
        };
        await prefs.setString("add1-image", ad["image"]);
        await prefs.setString("add1-link", ad["link"]);
      } else if (id == 2) {
        calenderBottomAd = {
          "image": ad["image"],
          "link": ad["link"],
          "active": true,
        };
        await prefs.setString("add2-image", ad["image"]);
        await prefs.setString("add2-link", ad["link"]);
      } else if (id == 3) {
        hadeesTopAd = {
          "image": ad["image"],
          "link": ad["link"],
          "active": true,
        };
        await prefs.setString("add3-image", ad["image"]);
        await prefs.setString("add3-link", ad["link"]);
      } else if (id == 4) {
        hadeesBottomAd = {
          "image": ad["image"],
          "link": ad["link"],
          "active": true,
        };
        await prefs.setString("add4-image", ad["image"]);
        await prefs.setString("add4-link", ad["link"]);
      } else {
        //
      }
    }
  }

  //insert local event to db

  Future<void> insertLocalEvent(String date, String event) async {
    try {
      await DBHelper.insertEvent(date, event);
      if (_allEvents[date] == null) {
        _allEvents[date] = [event];
      } else {
        _allEvents[date]?.add(event);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  // 2nd function

  Future<void> loadFromLocally() async {
    //loading data from local sql
    print("Loading data frmo local sql");

    //working with local events

    final List<Map<String, dynamic>> dbLocalEvents =
        await DBHelper.getLocalEvents();
    dbLocalEvents.forEach((event) {
      String dt = event["date"];
      String ev = event["event"];
      if (_allEvents[dt] == null) {
        _allEvents[dt] = [ev];
      } else {
        _allEvents[dt]?.add(ev);
      }
    });

    //working with events

    final List<Map<String, dynamic>> dbEvents = await DBHelper.getEvents();
    for (var event in dbEvents) {
      String dt = event["date"];
      String ev = event["event"];
      if (_allEvents[dt] == null) {
        _allEvents[dt] = [ev];
      } else {
        _allEvents[dt]?.add(ev);
      }
    }

    //working with hadees

    final List<Map<String, dynamic>> hadeeses = await DBHelper.getHadees();
    for (var hadees in hadeeses) {
      String h = hadees["hadees"];
      _allHadees.add(h);
    }

    //working with ads

    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("add1-image")) {
      final image = prefs.getString("add1-image");
      final link = prefs.getString("add1-link");
      calenderTopAd = {
        "image": image,
        "link": link,
        "active": true,
      };
    } else {
      calenderTopAd = null;
    }

    if (prefs.containsKey("add2-image")) {
      final image = prefs.getString("add2-image");
      final link = prefs.getString("add2-link");
      calenderBottomAd = {
        "image": image,
        "link": link,
        "active": true,
      };
    } else {
      calenderBottomAd = null;
    }

    if (prefs.containsKey("add3-image")) {
      final image = prefs.getString("add3-image");
      final link = prefs.getString("add3-link");
      hadeesTopAd = {
        "image": image,
        "link": link,
        "active": true,
      };
    } else {
      hadeesTopAd = null;
    }

    if (prefs.containsKey("add4-image")) {
      final image = prefs.getString("add4-image");
      final link = prefs.getString("add4-link");
      hadeesBottomAd = {
        "image": image,
        "link": link,
        "active": true,
      };
    } else {
      hadeesBottomAd = null;
    }
  }

  // 3rd function

  Future<void> setAndFetchdata() async {
    try {
      //check for internet
      var connectivityResult = await (Connectivity().checkConnectivity());

      //load local storage

      final prefs = await SharedPreferences.getInstance();

      //checking for internet

      if (connectivityResult == ConnectivityResult.none) {
        //internet not avalable
        print("No internet");

        //load data from sql

        // await loadFromLocally();
      } else {
        //internet available
        print("Internet available");

        //checking online version

        print("internet available calling api");

        // final url = "${Settings.apiUrl}/version";

        // final response = await http.get(Uri.parse(url));
        // final responseData = json.decode(response.body);

        // //found online db version

        // final version = responseData["version"];

        // //checking for offline version

        // if (!prefs.containsKey("version")) {
        //   //no old version

        //   print("no old version found");

        //   //store online version in prefs
        //   await prefs.setString("version", version);

        //   //load frmo online

        //   await loadFromOnline();
        // } else {
        //   //compare online and offline db version

        //   print("old version found");
        //   if (prefs.getString("version") == version) {
        //     //offline and online db version is same

        //     print("old version is same");
        //     await loadFromLocally();
        //  }
        //  else {
        //   //online version is updated

        //   //store online db version in prefs
        //   await prefs.setString("version", version);
        //   await loadFromOnline();
        // }
        //  }
      }
    } catch (err) {
      print(err.toString());
    }
  }
}

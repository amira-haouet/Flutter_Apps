import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshop5/dbuse.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 dbuse helper = dbuse();
 helper.testDb();
 return MaterialApp(
 title: 'Shoppping List',
 theme: ThemeData(
 primarySwatch: Colors.blue,
 ),
 home: Container());
 }
}

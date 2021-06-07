import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/services.dart';


Future<String> excelToJson() async {
  var file = await FilePicker.getFilePath(
      type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls']);

  // print(file);
  print("after input");
  var bytes = File(file).readAsBytesSync();
  print("after bytes");
  var excel = Excel.decodeBytes(bytes);
  print("Ankit"+ file.toString());
  print("after excel decodes");
  int i = 0;
  List<dynamic> keys = new List<dynamic>();
  List<Map<String, dynamic>> json = new List<Map<String, dynamic>>();
  print('after json list init');
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table].rows) {
      print("print Inside 2nd loop");
      if (i == 0) {
        keys = row;
        i++;
      } else {
        Map<String, dynamic> temp = Map<String, dynamic>();
        int j = 0;
        String tk = '';
        for (var key in keys) {
          tk = "\u201C" + key + "\u201D";
          temp[tk] = (row[j].runtimeType == String)
              ? "\u201C" + row[j].toString() + "\u201D"
              : row[j];
          j++;
        }
        json.add(temp);
      }
      print("print last Inside 2nd loop");
    }
  }
  print("print Outside  loop");
  print("Length--------"+ json.length.toString());
  String fullJson = json.toString().substring(1, json.toString().length - 1);
  print(fullJson);
  return fullJson;
}






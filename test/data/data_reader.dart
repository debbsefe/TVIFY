import 'dart:io';

String dataReader(String name) => File('test/data/$name').readAsStringSync();

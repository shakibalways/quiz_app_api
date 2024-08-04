import 'dart:convert';

import 'package:http/http.dart' as http;

var apilink ="https://opentdb.com/api.php?amount=20&category=18";
getQuizData()async{
var res =await http.get(Uri.parse(apilink));
if(res.statusCode==200){
  var data = jsonDecode(res.body.toString());
  return data;

}

}
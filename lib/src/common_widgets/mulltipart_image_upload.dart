
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ImagesMultiPart {
  multipartProdecudre(String url,String imagepath) async {
   
   final endpoint = Environment().config.apiHost;
    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(endpoint + url));

    //for token
    //request.headers.addAll({"Authorization": "Bearer token"});

    //for image and videos and files

    request.files.add(await http.MultipartFile.fromPath("images", imagepath));

    //for completeing the request
    var response =await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);


     if (response.statusCode==200) {
        print("SUCCESS");
        print(responseData);
      }
     else {
      print("ERROR");
    }
  }

Future<String> uploadImage(url,filepath) async {
   final endpoint = Environment().config.apiHost;
  var request = http.MultipartRequest('POST', Uri.parse(endpoint + url));
  request.files.add(await http.MultipartFile.fromPath('images', filepath));
  var res = await request.send();
  return res.statusCode.toString();
}
  
  }
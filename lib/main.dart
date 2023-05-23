
// ignore_for_file: non_constant_identifier_names, unused_label

import 'package:flutter/material.dart';
//import 'scr.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

 void main(){


  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondPage(),
    )
  );
 }
 class firrstpage extends StatelessWidget {
   firrstpage({super.key});
  var _categoryNameController= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     body: Material(
      color:   Colors.white,
      child: Center(
        child:ListView(
          children: <Widget> [
            const Padding(padding: EdgeInsets.all(30.0)) ,
            // new Image.asset('images/photohobay.png',
            // width: 200.0,
            // height: 200.0
            // ,) 
             ListTile(
              title:  TextFormField(
                controller:_categoryNameController,
                decoration:  InputDecoration(
                  labelText: "enter a categary",
                  hintText: 'eg, dogs, cats...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)
                ),
              ),
              
            ),
             const Padding(padding: EdgeInsets.all(4.0),) ,
             ListTile(
             title:Material(
                color: Colors.blue,
                elevation: 5.0,
                borderRadius: BorderRadius.circular(25.0),
                child: MaterialButton(
                  height: 10,
                  onPressed: (){

                },
                child:const Text('search',style:TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.white  )),)
              ), 
            )
          ],
        )
      ),
     ),
    );
  }
}
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: 
        const Text('search',style:TextStyle(color: Colors.white  ),),
        centerTitle: true,
        
        ),
        body:  FutureBuilder(
          future: GetPics(),
          builder: (context, snapshot) {
            Map? data=snapshot.data;
            if(snapshot.hasError){
              print(snapshot.error);
               return Text('faild to get response form the server');
            }
            else if(snapshot.hasData){
              return Center(
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    childern: <Widget>[
                      const Padding(padding: EdgeInsets.all(5.0)),
                       Container(
                        child: InkWell(
                          onTap: (){},
                          child: Image.network(
                            '${data['hits'][index]['largeImageUrl']}'
                          ),
                          ),
                      )

                    ];
                    
                  }, ),
              );
              
            

          
          
          }
            else{
                return 
                  Text('$data');
                
              
            }
          }
        )
        
      
    );
  }
}
Future <Map> GetPics() async{
const  apiKey='36684516-4d8c0a326c01fc11ecba49112';
  String url='https://pixabay.com/api/?key=$apiKey&q=cars&image_type=photo&pretty=true';
  
http.Response response=await http.get(Uri.parse(url));
print(json.decode(response.body));
return json.decode(response.body);


}
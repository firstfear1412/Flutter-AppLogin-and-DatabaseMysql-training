// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Future logout() async {
    await User.setsignin(false);
    Navigator.pushNamed(context, 'login');
  }
  //async เพราะว่าเป็นการดึงข้อมูลจาก URL
  Future all_image() async {
    var url = "http://192.168.127.41/flutter_loginDB_training/image.php";
    final response = await http.post(Uri.parse(url));
    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Homepage Flutter Login-php"),
      ),
      body: Center(
        child: Column(
          children: [
            //header text
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome To Flutter Homepage",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                    height: 20,
                  ),
            //content ตรงกลางหน้าจอ ใช้เพื่อแบ่งแยก header กับ button ล่าง
            Expanded(
              //เว้นช่องว่างไว้เฉยๆ
              // child: Center()
              //ใส่ content ที่ต้องการ
              child: FutureBuilder(
                future: all_image(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.hasError)print(snapshot.error);
                  return snapshot.hasData 
                  // ? คือ if : คือ else ของ พวก container
                  ?
                    Container(
                      // ใช้ Stack เพื่อวาง Widget ทับกัน
                      child: Stack(
                        children: [
                          Container(
                            //ListView ไว้ทำให้หน้าจอ เลื่อนขึ้นเลื่อนลงได้ ตามจำนวนข้อมูลที่ดึงมา
                            child: ListView.builder(
                              //นับ data ว่ามีกี่ตัว เพื่อที่จะแสดงใน ListView ตามจำนวนนั้นๆ
                              itemCount: snapshot.data.length,
                              //สร้างตามจำนวนที่นับได้ <= จะ build function สำหรับแต่ละ item นั้นๆ ใน ลิสต์
                              itemBuilder: (context,index){
                                List list = snapshot.data;
                                //return จะสามารถ ส่งค่า container ได้แค่ตัวเดียว ดังนั้นจึงต้องกรุ๊ป container ทั้งหมดไว้ในตัวเดียว
                                return Container(
                                  decoration: BoxDecoration(),
                                  // ต้องสร้าง child 
                                  child: Column(
                                    //ต้องสร้าง children ภายใต้ child เพื่อให้สามารถนำ container หลายตัวมาเป็นลูกของ Container หลัก ได้
                                    children: [
                                      // 1 container ของ รูปภาพ
                                      Container(
                                        child: Image.network(
                                          "http://192.168.127.41/flutter_loginDB_training/uploads/${list[index]['image']}"
                                        ),
                                      ),
                                      // 2 container ของ Text Attribute
                                      Container(
                                        width: double.infinity,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  list[index]['name'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              )
                                            ]
                                          ),
                                      )
                                    ]
                                  ),
                                );
                              }
                            ),
                          )
                        ]
                      ),
                    )
                  :Center(child: Container(),
                  );
                },
              ),
            ),
            //ปุ่ม sign out
            Container(
              child: SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF3F60A0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    //check สถานะล็อคอินก่อน
                    // Navigator.pushNamed(context, 'login');
                    logout();
                  },
                  child: Text("Sign out"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/data/repository/chat_dto.dart';

class ChatWidget extends StatelessWidget{
  List<ChatDto> chatList;

  ChatWidget({required this.chatList});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._messageDesign(),
      ],
    );
  }

  List<Widget> _messageDesign(){
    return chatList.map((chat) {
      if(chat.rol == 'U'){
        return Column(
          children:[ 
             SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200, 
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Wrap( 
                      children: [
                        Text(
                          chat.content,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(width: 5,),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 15,
                      color: Colors.white,
                    ),
          
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 5,
          ),
          ],
        );
      }else{
        return Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 15,
                      color: Colors.white,
                    ),
        
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 200, 
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Wrap( 
                    children: [
                      Text(
                        chat.content,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                )
              ],
            ),
            SizedBox(height: 5),
          ],
        );
      }
    }).toList();
  }

  // Card _messageDesign({required String content, required String rol, required DateTime created_at}){
  //   if(rol == 'U'){}
  //   else{
  //     return 
  //   }
  // }
}

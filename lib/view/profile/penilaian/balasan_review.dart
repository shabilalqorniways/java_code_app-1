import 'package:flutter/material.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';

class BalasanReview extends StatefulWidget {
  const BalasanReview({Key? key}) : super(key: key);

  @override
  _BalasanReviewState createState() => _BalasanReviewState();
}

class _BalasanReviewState extends State<BalasanReview> {
  List listBoxChat = [
    true,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 229, 229, 229),
            appBar: const CostumeAppBar(
              title: '',
              profileTitle: 'BalasanReview',
              back: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    child: Center(
                        child: Stack(
                      children: [
                        Image.asset("assert/image/bg_daftarpenilaian.png"),
                        ListView.builder(
                          itemCount: listBoxChat.length,
                          itemBuilder: (context, index) {
                            return boxChat(context, listBoxChat[index]);
                          },
                        ),
                      ],
                    ))),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 18.0,
                          top: 5,
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(46, 46, 46, 0.25)),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tulis Pesan ...'),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.add_photo_alternate_outlined)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: 15,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 5),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send),
                        color: Color.fromRGBO(0, 154, 173, 1),
                      )),
                ],
              ),
            ),
          );
        });
  }

  Padding boxChat(BuildContext context, positionBox) {
    var colorBoxChat = Color.fromRGBO(223, 239, 241, 0.5);
    var timeBoxChat;
    if (positionBox == true) {
      positionBox = Alignment.centerRight;
      colorBoxChat = Color.fromRGBO(223, 239, 241, 0.5);
      timeBoxChat = Padding(
        padding: const EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
        child: Align(
          alignment: positionBox,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '05.05',
                  textAlign: TextAlign.right,
                ),
                Icon(Icons.person)
              ]),
        ),
      );
    } else if (positionBox == false) {
      positionBox = Alignment.centerLeft;
      colorBoxChat = Color.fromRGBO(240, 240, 240, 0.5);
      timeBoxChat = Padding(
        padding: const EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
        child: Align(
          alignment: positionBox,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  color: Color.fromRGBO(0, 154, 173, 1),
                ),
                Text(
                  'Bro Gil ',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 154, 173, 1),
                  ),
                ),
                Text(
                  '05.05',
                  textAlign: TextAlign.right,
                ),
              ]),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: positionBox,
        child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                color: colorBoxChat,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child: Column(
              children: [
                timeBoxChat,
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

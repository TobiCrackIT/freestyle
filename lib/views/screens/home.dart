import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        elevation: 1,
        leading: Padding(
          padding: EdgeInsets.only(left: 30, right: 4),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Mysterium VPN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 2,
              ),
              height: 2,
              width: 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(
                  0xffC4C4C4,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Color(0xffF2F2F3),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.mic,
              color: Color(0xffAAAAAA),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  hoverColor: Colors.transparent,
                  elevation: 0.0,
                  focusElevation: 0.0,
                  hoverElevation: 0.0,
                  fillColor: Color(
                    0xffEFEFEF,
                  ),
                  highlightElevation: 0.0,
                  animationDuration: Duration.zero,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  constraints:
                      const BoxConstraints(maxWidth: 80.0, minHeight: 36.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      'Connect',
                      style: const TextStyle(
                        color: Color(0xff666666),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

///Customn transitions modal
class Custom extends CustomTransition {
  Custom()
      : super(
          opaque: false,
          transitionBuilder: (p0, p1, p2, p3) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: p1.drive(tween),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: p3,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
}

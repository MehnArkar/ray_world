import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class WorldCollidable extends PositionComponent{
  WorldCollidable() {add(RectangleHitbox());}
}
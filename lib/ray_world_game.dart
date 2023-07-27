import 'dart:ui';
import 'package:flame/game.dart';
import 'package:ray_world/components/world_collidable.dart';
import '../helpers/direction.dart';
import 'components/player.dart';
import 'components/world.dart' as w;
import 'helpers/map_loader.dart';


class RayWorldGame extends FlameGame with HasCollisionDetection{
  final Player _player = Player();
  final w.World _world = w.World();

  @override
  Future<void> onLoad() async {
    await add(_world);
    await add(_player);
    addWorldCollision();

    _player.position = _world.size / 2;
    camera.followComponent(
        _player, 
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  Future<void> addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });


  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }
}

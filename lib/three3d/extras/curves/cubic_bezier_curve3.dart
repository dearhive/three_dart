import 'package:three_dart/three3d/math/vector3.dart';
import '../core/curve.dart';

class CubicBezierCurve3 extends Curve {

  CubicBezierCurve3(Vector3? v0, Vector3? v1, Vector3? v2, Vector3? v3) {
    type = "CubicBezierCurve3";
    isCubicBezierCurve3 = true;
    this.v0 = v0 ?? Vector3.init();
    this.v1 = v1 ?? Vector3.init();
    this.v2 = v2 ?? Vector3.init();
    this.v3 = v3 ?? Vector3.init();
  }

  CubicBezierCurve3.fromJSON(Map<String, dynamic> json) {
    type = "CubicBezierCurve3";
    isCubicBezierCurve = true;
    v0 = Vector3.fromJSON(json["v0"]);
    v1 = Vector3.fromJSON(json["v1"]);
    v2 = Vector3.fromJSON(json["v2"]);
    v3 = Vector3.fromJSON(json["v3"]);
  }

  @override
  Vector3 getPoint(num t, optionalTarget) {
    var tx = _cubicBezier(t, v0.x, v1.x, v2.x, v3.x);
    var ty = _cubicBezier(t, v0.y, v1.y, v2.y, v3.y);
    var tz = _cubicBezier(t, v0.z, v1.z, v2.z, v3.z);

    if (optionalTarget != null) {
      optionalTarget.set(tx, ty, tz);
      return optionalTarget;
    } else {
      return Vector3(tx.toDouble(), ty.toDouble(), tz.toDouble());
    }
  }

  @override
  List<Vector3> getPoints([num divisions = 5]) {
      List<Vector3> points = [];

      for (var d = 0; d <= divisions; d++) {
        points.add(getPoint(d / divisions, null));
      }

      return points;
  }


  num _cubicBezier(num t, num p0, num p1, num p2, num p3) {
    var k = 1 - t;
    return k * k * k * p0 +
        3 * k * k * t * p1 +
        3 * k * t * t * p2 +
        t * t * t * p3;
  }

  @override
  toJSON() {
    var data = super.toJSON();
    data["v0"] = {"x": v0.x, "y": v0.y, "z": v0.z};
    data["v1"] = {"x": v1.x, "y": v1.y, "z": v1.z};
    data["v2"] = {"x": v2.x, "y": v2.y, "z": v2.z};
    data["v3"] = {"x": v3.x, "y": v3.y, "z": v3.z};
    return data;
  }
}
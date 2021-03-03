///
/// This library is free software; you can redistribute it and/or
/// modify it under the terms of the GNU Lesser General Public
/// License as published by the Free Software Foundation; either
/// version 2.1 of the License, or (at your option) any later version.
///
/// This library is distributed in the hope that it will be useful,
/// but WITHOUT ANY WARRANTY; without even the implied warranty of
/// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
/// Lesser General Public License for more details.
///
/// You should have received a copy of the GNU Lesser General Public
/// License along with this library; if not, write to the Free Software
/// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
/// MA 02110-1301  USA
///

part of cairodart.test;

runPatternTests() {
  group('Pattern', () {
    test('should have Success status when created', () {
      Pattern pattern = new LinearGradient(10.0, 10.0, 20.0, 20.0);
      expect(pattern.status, equals(CairoStatus.Success));
    });
    test('should correctly get/set extend', () {
      Pattern pattern = new LinearGradient(10.0, 10.0, 20.0, 20.0);
      expect(pattern.extend, equals(Extend.Pad));

      pattern.extend = Extend.Reflect;

      expect(pattern.extend, equals(Extend.Reflect));
    });
    test('should have correct pattern type', () {
      Pattern pattern = new MeshPattern();
      expect(pattern.patternType, equals(PatternType.Mesh));

      pattern = new SolidPattern.fromRgb(0.0, 0.0, 0.0);
      expect(pattern.patternType, equals(PatternType.Solid));

      pattern = new SolidPattern.fromRgba(0.0, 0.0, 0.0, 0.0);
      expect(pattern.patternType, equals(PatternType.Solid));

      pattern = new LinearGradient(0.0, 0.0, 10.0, 10.0);
      expect(pattern.patternType, equals(PatternType.Linear));

      pattern = new RadialGradient(0.0, 0.0, 5.0, 10.0, 10.0, 10.0);
      expect(pattern.patternType, equals(PatternType.Radial));

      Surface surface = new ImageSurface(Format.ARGB32, 10, 10);
      pattern = new SurfacePattern(surface);
      expect(pattern.patternType, equals(PatternType.Surface));
    });
    test('should correctly get/set matrix', () {
      Pattern pattern = new LinearGradient(10.0, 10.0, 15.0, 15.0);
      pattern.matrix = new Matrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
      expect(pattern.matrix, (Matrix m) => m.xx == 1.0 && m.yx == 2.0 && m.xy == 3.0 && m.yy == 4.0 && m.x0 == 5.0 && m.y0 == 6.0);
    });
  });
  group('Mesh pattern', () {
    test('get control point', () {
      MeshPattern pattern = new MeshPattern();
      pattern.beginPatch();
      pattern.setControlPoint(0, new Point.from(20.0, 10.0));
      Point p = pattern.getControlPoint(0, 0);

      expect(0.0, equals(p.x));
      expect(0.0, equals(p.y));
    });
    test('get corner color', () {
      MeshPattern pattern = new MeshPattern();
      pattern.beginPatch();
      pattern.setCornerColor(0, new Color.rgb(30.0, 10.0, 50.0));
      Color color = pattern.getCornerColor(0, 0);
    });
    test('get patch count', () {
      MeshPattern pattern = new MeshPattern();
      pattern.beginPatch();
      int count = pattern.patchCount;

      expect(0, equals(count));
    });


  });
  group('Solid pattern', () {
    test('should correctly return pattern color for solid pattern', () {
      SolidPattern pattern = new SolidPattern.fromColor(new Color.rgba(0.5, 0.6, 0.7, 0.5), true);
      expect(pattern.color, equals(new Color.rgba(0.5, 0.6, 0.7, 1.0)));
    });
    test('should correctly return pattern color', () {
      SolidPattern pattern = new SolidPattern.fromColor(new Color.rgba(0.5, 0.6, 0.7, 0.5));
      expect(pattern.color, equals(new Color.rgba(0.5, 0.6, 0.7, 0.5)));
    });
  });
  group('Gradient', () {
    test('should correctly set/get color stop', () {
      var pattern = new LinearGradient(0.0, 0.0, 800.0, 800.0);
      pattern.addColorStop(new ColorStop(new Color.rgba(0.5, 0.6, 0.7, 0.5), 0.4));

      expect(pattern.colorStopCount, equals(1));
      pattern.addColorStop(new ColorStop(new Color.rgba(0.6, 0.5, 0.4, 0.3), 0.2));
      expect(pattern.colorStopCount, equals(2));

      expect(pattern.colorStopAt(1), (ColorStop stop) {
        return stop.offset == 0.4 &&
        stop.color.red == 0.5 &&
        stop.color.green == 0.6 &&
        stop.color.blue == 0.7 &&
        stop.color.alpha == 0.5;
      });


      expect(pattern.colorStopAt(0), (ColorStop stop) {
        return stop.offset == 0.2 &&
        stop.color.red == 0.6 &&
        stop.color.green == 0.5 &&
        stop.color.blue == 0.4 &&
        stop.color.alpha == 0.3;
      });

    });

  });
  group('Linear gradient', () {
    test('should correctly obtain linear points', () {
      LinearGradient pattern = new LinearGradient(10.0, 15.0, 100.0, 150.0);
      List<Point> points = pattern.linearPoints;

      expect(points[0], (Point p) => p.x == 10.0 && p.y == 15.0);
      expect(points[1], (Point p) => p.x == 100.0 && p.y == 150.0);
    });
  });
  group('Radial gradient', () {
    test('should correctly obtain radial circles', () {
      var pattern = new RadialGradient(10.0, 15.0, 20.0, 100.0, 150.0, 30.0);
      List<Circle> circles = pattern.radialCircles;

      expect(circles[0], (Circle c) => c.x == 10.0 && c.y == 15.0 && c.radius == 20.0);
      expect(circles[1], (Circle c) => c.x == 100.0 && c.y == 150.0 && c.radius == 30.0);
    });
  });
  group('Surface pattern', () {
    test('should correctly get/set filter', () {
      var pattern = new SurfacePattern(new ImageSurface(Format.ARGB32, 640, 480));
      expect(pattern.filter, equals(Filter.Good));

      pattern.filter = Filter.Best;

      expect(pattern.filter, equals(Filter.Best));
    });
  });
}
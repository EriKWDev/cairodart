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

runRegionTests() {
  group('Region', () {
    test('should be successfully created with default constructor', () {
      Region region = new Region();
      expect(region.status, CairoStatus.Success);
    });
    test('should be successfully created with "fromArea" constructor', () {
      Region region = new Region.fromArea(10, 15, 100, 150);
      expect(region.status, CairoStatus.Success);
    });
    test('should be successfully created with "fromRectangle" constructor', () {
      Rectangle rect = new Rectangle(10, 15, 100, 150);
      Region region = new Region.fromRectangle(rect);
      expect(region.status, CairoStatus.Success);
    });
    test('should be successfully created with "fromRectangles" constructor', () {
      Rectangle rect = new Rectangle(10, 15, 100, 150);
      Rectangle rect2 = new Rectangle(20, 25, 200, 250);

      Region region = new Region.fromRectangles([rect, rect2]);
      expect(region.status, CairoStatus.Success);
    });
    test('should be successfully copied from another region', () {
      Region region = new Region();
      Region copy = region.copy();
      expect(copy, isNotNull);
      expect(copy.status, CairoStatus.Success);
    });
    test('should correctly return extents', () {
      Rectangle ext = new Rectangle(10, 20, 100, 200);
      Region region = new Region.fromRectangle(ext);
      Rectangle res = region.getExtents();
      expect(res, equals(ext));
    });
    test('should correctly return number of rectangles for one rectangle', () {
      Rectangle ext = new Rectangle(10, 20, 100, 200);
      Region region = new Region.fromRectangle(ext);
      expect(region.countOfRectangles, equals(1));
    });
    test('should correctly return number of rectangles for 2 not intersected rectangles', () {
      Rectangle ext1 = new Rectangle(10, 20, 30, 40);
      Rectangle ext2 = new Rectangle(100, 200, 150, 250);
      Region region = new Region.fromRectangles([ext1, ext2]);
      expect(region.countOfRectangles, equals(2));
    });
    test('should correctly return number of rectangles for 2 intersected rectangles', () {
      Rectangle ext1 = new Rectangle(10, 20, 30, 40);
      Rectangle ext2 = new Rectangle(25, 35, 150, 250);
      Region region = new Region.fromRectangles([ext1, ext2]);
      expect(region.countOfRectangles, equals(3));
    });
    test('should correctly return rectangles', () {
      Rectangle ext1 = new Rectangle(10, 20, 30, 40);
      Rectangle ext2 = new Rectangle(100, 200, 150, 250);
      Region region = new Region.fromRectangles([ext1, ext2]);
      Rectangle res1 = region.rectangleAt(0);
      Rectangle res2 = region.rectangleAt(1);

      expect(res1, equals(ext1));
      expect(res2, equals(ext2));
    });
    test('should be empty if there is no rectangles', () {
      Region region = new Region();
      expect(region.isEmpty, isTrue);
    });
    test('should not be empty if there are rectangles', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      expect(region.isEmpty, isFalse);
    });
    test('should contain point within one of rectangles in region', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      expect(region.containsPointWithCoords(12, 12), isTrue);
    });
    test('should not contain point outside of rectangle in region', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      expect(region.containsPointWithCoords(5, 5), isFalse);
    });
    test('should contain point within one of rectangles in region when Point is used', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      expect(region.containsPoint(new Point.from(12.0, 12.0)), isTrue);
    });
    test('should not contain point outside of rectangle in region when Point is used', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      expect(region.containsPoint(new Point.from(5.0, 5.0)), isFalse);
    });
    test('should contain smaller rectangle in larger', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      Rectangle smaller = new Rectangle(15, 15, 80, 80);
      expect(region.containsRectangle(smaller), equals(RegionOverlap.OverlapIn));
    });
    test('should not contain smaller rectangle in larger', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      Rectangle smaller = new Rectangle(1, 1, 5, 5);
      expect(region.containsRectangle(smaller), equals(RegionOverlap.OverlapOut));
    });
    test('should overlap with smaller rectangle', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region = new Region.fromRectangle(rect);
      Rectangle smaller = new Rectangle(1, 1, 12, 12);
      expect(region.containsRectangle(smaller), equals(RegionOverlap.OverlapPart));
    });
    test('should be equal to another region with the same rectangle(s)', () {
      Rectangle rect = new Rectangle(10, 10, 100, 100);
      Region region1 = new Region.fromRectangle(rect);
      Region region2 = new Region.fromRectangle(rect);
      expect(region1, equals(region2));
    });
    test('should not be equal to another region with another rectangle(s)', () {
      Rectangle rect1 = new Rectangle(10, 10, 100, 100);
      Rectangle rect2 = new Rectangle(15, 15, 150, 150);
      Region region1 = new Region.fromRectangle(rect1);
      Region region2 = new Region.fromRectangle(rect2);
      expect(region1 == region2, isFalse);
    });
    test('should be successfully translated using translate() method', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      region.translate(5, 5);
      Rectangle resultRect = region.rectangleAt(0);
      expect(resultRect, equals(new Rectangle(5, 5, 10, 10)));
    });
    test('should be successfully translated using translateToDistance() method', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      region.translateToDistance(new Distance.from(5.0, 5.0));
      Rectangle resultRect = region.rectangleAt(0);
      expect(resultRect, equals(new Rectangle(5, 5, 10, 10)));
    });
    test('should successfully intersect with other region', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle otherRect = new Rectangle(5, 5, 10, 10);
      Region otherRegion = new Region.fromRectangle(otherRect);
      region.intersect(otherRegion);
      Rectangle result = region.rectangleAt(0);
      expect(result, equals(new Rectangle(5, 5, 5, 5)));
    });
    test('should successfully intersect with rectangle', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle otherRect = new Rectangle(5, 5, 10, 10);

      region.intersectRectangle(otherRect);
      Rectangle result = region.rectangleAt(0);
      expect(result, equals(new Rectangle(5, 5, 5, 5)));
    });
    test('should successfully intersect with rectangle by coords', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      region.intersectRectangleWithCoords(5, 5, 10, 10);
      Rectangle result = region.rectangleAt(0);
      expect(result, equals(new Rectangle(5, 5, 5, 5)));
    });
    test('should successfully subtract other region', () {
      Rectangle rect1 = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect1);
      Rectangle rect2 = new Rectangle(5, 0, 10, 10);
      Region other = new Region.fromRectangle(rect2);

      region.subtract(other);
      Rectangle subtracted = region.rectangleAt(0);
      expect(subtracted, equals(new Rectangle(0, 0, 5, 10)));
    });
    test('should successfully subtract a rectangle', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle other = new Rectangle(5, 0, 10, 10);

      region.subtractRectangle(other);
      Rectangle subtracted = region.rectangleAt(0);
      expect(subtracted, equals(new Rectangle(0, 0, 5, 10)));
    });
    test('should successfully subtract a rectangle by coords', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);

      region.subtractRectangleWithCoords(5, 0, 10, 10);
      Rectangle subtracted = region.rectangleAt(0);
      expect(subtracted, equals(new Rectangle(0, 0, 5, 10)));
    });
    test('should successfully union with other region', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle otherRect = new Rectangle(10, 0, 10, 10);
      Region other = new Region.fromRectangle(otherRect);

      region.union(other);
      Rectangle union = region.rectangleAt(0);
      expect(union, equals(new Rectangle(0, 0, 20, 10)));
    });
    test('should successfully union with a rectangle', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle other = new Rectangle(10, 0, 10, 10);

      region.unionRectangle(other);
      Rectangle union = region.rectangleAt(0);
      expect(union, equals(new Rectangle(0, 0, 20, 10)));
    });
    test('should successfully union with a rectangle by coords', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);

      region.unionRectangleWithCoords(10, 0, 10, 10);
      Rectangle union = region.rectangleAt(0);
      expect(union, equals(new Rectangle(0, 0, 20, 10)));
    });
    test('should successfully XOR with other region', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle otherRect = new Rectangle(5, 0, 10, 10);
      Region other = new Region.fromRectangle(otherRect);

      region.xor(other);
      Rectangle xor = region.rectangleAt(0);
      expect(xor, equals(new Rectangle(0, 0, 5, 10)));
    });
    test('should successfully XOR with a rectangle', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);
      Rectangle other = new Rectangle(5, 0, 10, 10);

      region.xorRectangle(other);
      Rectangle xor = region.rectangleAt(0);
      expect(xor, equals(new Rectangle(0, 0, 5, 10)));
    });
    test('should successfully XOR with a rectangle by coords', () {
      Rectangle rect = new Rectangle(0, 0, 10, 10);
      Region region = new Region.fromRectangle(rect);

      region.xorRectangleWithCoords(5, 0, 10, 10);
      Rectangle xor = region.rectangleAt(0);
      expect(xor, equals(new Rectangle(0, 0, 5, 10)));
    });

 });
}
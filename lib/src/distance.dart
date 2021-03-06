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

part of cairodart.base;

///
/// Represents the distance between two points.
///
abstract class Distance {

  factory Distance() => new _Distance(0.0, 0.0);
  factory Distance.from(num dx, num dy) => new _Distance(dx.toDouble(), dy.toDouble());

  /// X-axis distance
  num get dx;

  /// Y-axis distance
  num get dy;
}

class _Distance implements Distance {

  num _dx;
  num _dy;

  _Distance(this._dx, this._dy);

  num get dx => _dx;
  num get dy => _dy;

  @override
  operator==(Object other) => other is Distance &&  dx == other.dx && dy == other.dy;
}



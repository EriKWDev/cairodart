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
/// Content class describes the content that a surface will contain, whether color
/// information, alpha information (translucence vs. opacity), or both.
///
abstract class Content {

  /// The surface will hold color content only
  static Content Color = new _Content(0x1000);

  /// The surface will hold color content only.
  static Content Alpha = new _Content(0x2000);

  /// The surface will hold color and alpha content
  static Content ColorAndAlpha = new _Content(0x3000);

  int get value;
}

class _Content extends Content {

  final int _value;

  _Content(this._value);

  int get value => _value;

  @override
  operator==(Object other) => other is Content &&  value == other.value;
}
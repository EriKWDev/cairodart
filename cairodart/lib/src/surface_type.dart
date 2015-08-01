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

abstract class SurfaceType {
  static final SurfaceType Image = new _SurfaceType(0);
  static final SurfaceType PDF = new _SurfaceType(1);
  static final SurfaceType PS = new _SurfaceType(2);
  static final SurfaceType XLib = new _SurfaceType(3);
  static final SurfaceType XCB = new _SurfaceType(4);
  static final SurfaceType Glitz = new _SurfaceType(5);
  static final SurfaceType Quartz = new _SurfaceType(6);
  static final SurfaceType Win32 = new _SurfaceType(7);
  static final SurfaceType BeOS = new _SurfaceType(8);
  static final SurfaceType DirectFB = new _SurfaceType(9);
  static final SurfaceType SVG = new _SurfaceType(10);
  static final SurfaceType OS2 = new _SurfaceType(11);
  static final SurfaceType Printing = new _SurfaceType(12);
  static final SurfaceType QuartzImage = new _SurfaceType(13);
  static final SurfaceType Script = new _SurfaceType(14);
  static final SurfaceType Qt = new _SurfaceType(15);
  static final SurfaceType Recording = new _SurfaceType(16);
  static final SurfaceType VG = new _SurfaceType(17);
  static final SurfaceType GL = new _SurfaceType(18);
  static final SurfaceType DRM = new _SurfaceType(19);
  static final SurfaceType TEE = new _SurfaceType(20);
  static final SurfaceType XML = new _SurfaceType(21);
  static final SurfaceType SKIA = new _SurfaceType(22);
  static final SurfaceType Subsurface = new _SurfaceType(23);
  static final SurfaceType COG = new _SurfaceType(24);
 
  int get value;
}

class _SurfaceType extends NativeFieldWrapperClass2 implements SurfaceType {
  
  int _val;
  
  _SurfaceType(this._val);
  
  int get value => _val;
  
  @override
  operator==(SurfaceType other) => value == other.value;
}
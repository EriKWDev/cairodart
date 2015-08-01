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

abstract class ColorStop {
  
  Color get color;
  double get offset;
  
  factory ColorStop(Color color, num offset) => new _ColorStop(color, offset.toDouble());
  
}

class _ColorStop implements ColorStop {
  
  Color _color;
  double _offset;
    
  
  Color get color => _color;
  double get offset => _offset;
    
  
  _ColorStop(this._color, this._offset);
  
}
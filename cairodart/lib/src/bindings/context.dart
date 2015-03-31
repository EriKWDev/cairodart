part of cairodart.base;

abstract class Context {
  
  factory Context(Surface surface) {
    return new _Context(surface);
  }
  
  void save();
  void restore();
  void pushGroup();
  void pushGroupWithContent(Content content);
  void popGroupToSource();
  void setSourceRgb(double red, double green, double blue);
  void setSourceRgba(double red, double green, double blue, double alpha);
  void stroke();
  void paint();
  
  LineCap lineCap;
  LineJoin lineJoin;
  double lineWidth;
  double miterLimit;
  
  Operator operator;
  
  Surface get target;
}


class _Context extends NativeFieldWrapperClass2 implements Context {
  
  Surface _surface;
  
  _Context(this._surface) {
    _create(_surface);
  }
  
  void _create(Surface surface) native 'context_create';
  
  void save() native 'save';
  
  void restore() native 'restore';
  
  void pushGroup() native 'push_group';
  
  void pushGroupWithContent(Content content) {
    _pushGroupWithContent(content.value);
  }
  
  void _pushGroupWithContent(int value) native 'push_group_with_content';
  
  void popGroupToSource() native 'pop_group_to_source';
  
  void setSourceRgb(double red, double green, double blue) native 'set_source_rgb';
  
  void setSourceRgba(double red, double green, double blue, double alpha) native 'set_source_rgba';
  
  void stroke() native 'stroke';
  
  void paint() native 'paint';
  
  Surface get target => _surface;
  
  LineCap get lineCap native 'get_line_cap';
  
  void set lineCap(LineCap cap) => _setLineCap(cap.value);
  
  void _setLineCap(int value) native 'set_line_cap';
  
  LineJoin get lineJoin native 'get_line_join';
  
  void set lineJoin(LineJoin join) => _setLineJoin(join.value);
  
  void _setLineJoin(int value) native 'set_line_join';
  
  double get lineWidth native 'get_line_width';
  
  void set lineWidth(double width) native 'set_line_width';
  
  double get miterLimit native 'get_miter_limit';
  
  void set miterLimit(double limit) native 'set_miter_limit';
  
  Operator get operator native 'get_operator';
  
  void set operator(Operator op) => _setOperator(op.value);
  
  void _setOperator(int val) native 'set_operator';
}

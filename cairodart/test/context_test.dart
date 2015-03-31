part of cairodart.test;

runContextTests() {
  group('Context', () {
    test('should be successfully created from ImageSurface', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
    });
    test('should successfully perform saving', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.save();
    });
    test('should successfully perform restoring', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.save();
      ctx.restore();
    });
    test('should successfully perform push group', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.pushGroup();
    });
    test('should successfully perform push group with content', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.pushGroupWithContent(Content.COLOR_ALPHA);
    });
    test('should successfully perform pop group to source', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.pushGroup();
      ctx.popGroupToSource();
    });
    test('should successfully set RGB', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.setSourceRgb(255.0, 255.0, 255.0);
    });
    test('should successfully set RGBA', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.setSourceRgba(255.0, 255.0, 255.0, 0.5);
    });
    test('should successfully stroke', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.stroke();
    });
    test('should successfully paint', () {
      Context ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.paint();
    });
    test('should return correct target', () {
      var surface = new ImageSurface(Format.ARGB32, 640, 480);
      Context ctx = new Context(surface);
      expect(ctx.target, surface);
    });
    test('should correctly get/set line cap', () {
      var ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.lineCap = LineCap.BUTT;
      expect(ctx.lineCap, equals(LineCap.BUTT));
      
      ctx.lineCap = LineCap.ROUND;
      expect(ctx.lineCap, equals(LineCap.ROUND));
      
      ctx.lineCap = LineCap.SQUARE;
      expect(ctx.lineCap, equals(LineCap.SQUARE));
    });
    test('should correctly get/set line join', () {
      var ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.lineJoin = LineJoin.MITER;
      expect(ctx.lineJoin, equals(LineJoin.MITER));
      
      ctx.lineJoin = LineJoin.ROUND;
      expect(ctx.lineJoin, equals(LineJoin.ROUND));
      
      ctx.lineJoin = LineJoin.BEVEL;
      expect(ctx.lineJoin, equals(LineJoin.BEVEL));
    });
    test('should correctly get/set line width', () {
      var ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.lineWidth = 3.0;
      expect(ctx.lineWidth, equals(3.0));
    });
    test('should correctly get/set miter limit', () {
      var ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      ctx.miterLimit = 20.0;
      expect(ctx.miterLimit, equals(20.0));
    });
    test('should correctly get/set operator', () {
      var ctx = new Context(new ImageSurface(Format.ARGB32, 640, 480));
      
      ctx.operator = Operator.ADD;
      expect(ctx.operator, equals(Operator.ADD));
      
      ctx.operator = Operator.ATOP;
      expect(ctx.operator, equals(Operator.ATOP));
            
      ctx.operator = Operator.CLEAR;
      expect(ctx.operator, equals(Operator.CLEAR));

      ctx.operator = Operator.COLOR_BURN;
      expect(ctx.operator, equals(Operator.COLOR_BURN));

      ctx.operator = Operator.COLOR_DODGE;
      expect(ctx.operator, equals(Operator.COLOR_DODGE));

      ctx.operator = Operator.DARKEN;
      expect(ctx.operator, equals(Operator.DARKEN));

      ctx.operator = Operator.DEST;
      expect(ctx.operator, equals(Operator.DEST));

      ctx.operator = Operator.DEST_ATOP;
      expect(ctx.operator, equals(Operator.DEST_ATOP));

      ctx.operator = Operator.DEST_IN;
      expect(ctx.operator, equals(Operator.DEST_IN));

      ctx.operator = Operator.DEST_OUT;
      expect(ctx.operator, equals(Operator.DEST_OUT));

      ctx.operator = Operator.DEST_OVER;
      expect(ctx.operator, equals(Operator.DEST_OVER));

      ctx.operator = Operator.DIFFERENCE;
      expect(ctx.operator, equals(Operator.DIFFERENCE));

      ctx.operator = Operator.EXCLUSION;
      expect(ctx.operator, equals(Operator.EXCLUSION));

      ctx.operator = Operator.HARD_LIGHT;
      expect(ctx.operator, equals(Operator.HARD_LIGHT));

      ctx.operator = Operator.HSL_COLOR;
      expect(ctx.operator, equals(Operator.HSL_COLOR));

      ctx.operator = Operator.HSL_HUE;
      expect(ctx.operator, equals(Operator.HSL_HUE));

      ctx.operator = Operator.HSL_LUMINOSITY;
      expect(ctx.operator, equals(Operator.HSL_LUMINOSITY));

      ctx.operator = Operator.HSL_SATURATION;
      expect(ctx.operator, equals(Operator.HSL_SATURATION));

      ctx.operator = Operator.IN;
      expect(ctx.operator, equals(Operator.IN));

      ctx.operator = Operator.LIGHTEN;
      expect(ctx.operator, equals(Operator.LIGHTEN));

      ctx.operator = Operator.MULTIPLY;
      expect(ctx.operator, equals(Operator.MULTIPLY));

      ctx.operator = Operator.OUT;
      expect(ctx.operator, equals(Operator.OUT));

      ctx.operator = Operator.OVER;
      expect(ctx.operator, equals(Operator.OVER));

      ctx.operator = Operator.OVERLAY;
      expect(ctx.operator, equals(Operator.OVERLAY));
      
      ctx.operator = Operator.SATURATE;
      expect(ctx.operator, equals(Operator.SATURATE));
      
      ctx.operator = Operator.SCREEN;
      expect(ctx.operator, equals(Operator.SCREEN));

      ctx.operator = Operator.SOFT_LIGHT;
      expect(ctx.operator, equals(Operator.SOFT_LIGHT));
      
      ctx.operator = Operator.SOURCE;
      expect(ctx.operator, equals(Operator.SOURCE));
    
      ctx.operator = Operator.XOR;
      expect(ctx.operator, equals(Operator.XOR));
    });
  });
}


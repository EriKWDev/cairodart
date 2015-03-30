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
  });
}


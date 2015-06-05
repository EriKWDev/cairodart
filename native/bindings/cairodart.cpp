#include <stdint.h>
#include <string.h>

#include <vector>
#include <cairo/cairo.h>

#include "argument.h"
#include "matrix.h"
#include "region.h"
#include "cairodart.h"
#include "bind.h"
#include "../error.h"
#include "list.h"
#include "factory.h"
#include "infrastructure/infrastructure.h"
#include "context.h"
#include "surface.h"
#include "pattern.h"

using namespace cairodart::infrastructure;

struct DartFunctionMap {
    const char* name;
    Dart_NativeFunction fun;
};

static DartFunctionMap FUNCTIONS_MAP[] = {
  { "context_create", context_create },
  { "save", save },
  { "restore", restore },
  { "push_group", push_group },
  { "push_group_with_content", push_group_with_content },
  { "pop_group_to_source", pop_group_to_source },
  { "pop_group", pop_group },
  { "set_source", set_source },
  { "get_source", get_source },
  { "set_source_rgb", set_source_rgb },
  { "set_source_rgba", set_source_rgba },
  { "stroke", stroke },
  { "stroke_preserve", stroke_preserve },
  { "in_stroke", in_stroke },
  { "stroke_extents", stroke_extents },
  { "paint", paint },
  { "set_line_cap", set_line_cap },
  { "get_line_cap", get_line_cap },
  { "set_line_join", set_line_join },
  { "get_line_join", get_line_join },
  { "set_line_width", set_line_width },
  { "get_line_width", get_line_width },
  { "set_miter_limit", set_miter_limit },
  { "get_miter_limit", get_miter_limit },
  { "set_operator", set_operator },
  { "get_operator", get_operator },
  { "set_fill_rule", set_fill_rule },
  { "get_fill_rule", get_fill_rule },
  { "has_current_point", has_current_point },
  { "move_to", move_to },
  { "line_to", line_to },
  { "rectangle", rectangle },
  { "get_current_point", get_current_point },
  { "new_path", new_path },
  { "new_sub_path", new_sub_path },
  { "close_path", close_path },
  { "arc", arc },
  { "arc_negative", arc_negative },
  { "curve_to", curve_to },
  { "rel_curve_to", rel_curve_to },
  { "rel_line_to", rel_line_to },
  { "rel_move_to", rel_move_to },
  { "text_path", text_path },
  { "path_extents", path_extents },
  { "get_antialias", get_antialias },
  { "set_antialias", set_antialias },
  { "get_tolerance", get_tolerance },
  { "set_tolerance", set_tolerance },
  { "clip", clip },
  { "clip_preserve", clip_preserve },
  { "in_clip", in_clip },
  { "reset_clip", reset_clip },
  { "clip_extents", clip_extents },
  { "fill", fill },
  { "fill_preserve", fill_preserve },
  { "fill_extents", fill_extents },
  { "in_fill", in_fill },
  { "copy_clip_rectangle_list", copy_clip_rectangle_list },
  { "rectangle_list_destroy", rectangle_list_destroy },
  { "mask", mask },
  { "mask_surface", mask_surface },
  { "paint_with_alpha", paint_with_alpha },
  { "show_page", show_page },
  { "copy_page", copy_page },
  { "get_dash", get_dash },
  { "set_dash", set_dash },
  { "get_dash_count", get_dash_count },
  { "set_source_surface", set_source_surface },
  { "get_group_target", get_group_target },
  { "image_surface_create", image_surface_create },
  { "image_surface_get_width", image_surface_get_width },
  { "image_surface_get_height", image_surface_get_height },
  { "format_stride_for_width", format_stride_for_width },
  { "image_surface_get_stride", image_surface_get_stride },
  { "surface_finish", surface_finish },
  { "surface_flush", surface_flush },
  { "surface_get_content", surface_get_content },
  { "surface_mark_dirty", surface_mark_dirty },
  { "surface_mark_dirty_rectangle", surface_mark_dirty_rectangle },
  { "surface_get_device_offset", surface_get_device_offset },
  { "surface_set_device_offset", surface_set_device_offset },
  { "surface_copy_page", surface_copy_page },
  { "surface_show_page", surface_show_page },
  { "surface_has_show_text_glyphs", surface_has_show_text_glyphs },
  { "surface_supports_mime_type", surface_supports_mime_type },
  { "surface_get_type", surface_get_type },
  { "surface_get_fallback_resolution", surface_get_fallback_resolution },
  { "surface_set_fallback_resolution", surface_set_fallback_resolution },
  { "surfaces_equals", surfaces_equals },
  { "image_surface_create_from_png", image_surface_create_from_png },
  { "surface_write_to_png", surface_write_to_png },
  { "pattern_create_rgb", pattern_create_rgb },
  { "pattern_create_rgba", pattern_create_rgba },
  { "pattern_create_for_surface", pattern_create_for_surface },
  { "pattern_create_linear", pattern_create_linear },
  { "pattern_create_radial", pattern_create_radial },
  { "pattern_create_mesh", pattern_create_mesh },
  { "pattern_mesh_begin_patch", pattern_mesh_begin_patch },
  { "pattern_mesh_end_patch", pattern_mesh_end_patch },
  { "pattern_mesh_move_to", pattern_mesh_move_to },
  { "pattern_mesh_line_to", pattern_mesh_line_to },
  { "pattern_mesh_curve_to", pattern_mesh_curve_to },
  { "pattern_mesh_get_control_point", pattern_mesh_get_control_point },
  { "pattern_mesh_set_control_point", pattern_mesh_set_control_point },
  { "pattern_mesh_get_corner_color", pattern_mesh_get_corner_color },
  { "pattern_mesh_set_corner_color", pattern_mesh_set_corner_color },
  { "pattern_mesh_get_patch_count", pattern_mesh_get_patch_count },
  { "pattern_add_color_stop_rgb", pattern_add_color_stop_rgb },
  { "pattern_add_color_stop_rgba", pattern_add_color_stop_rgba },
  { "pattern_get_color_stop_count", pattern_get_color_stop_count },
  { "pattern_get_color_stop_rgba", pattern_get_color_stop_rgba },
  { "pattern_get_linear_points", pattern_get_linear_points },
  { "pattern_get_radial_circles", pattern_get_radial_circles },
  { "pattern_get_extend", pattern_get_extend },
  { "pattern_set_extend", pattern_set_extend },
  { "pattern_get_filter", pattern_get_filter },
  { "pattern_set_filter", pattern_set_filter },
  { "pattern_get_type", pattern_get_type },
  { "pattern_get_matrix", pattern_get_matrix },
  { "pattern_set_matrix", pattern_set_matrix },
  { "pattern_equals", pattern_equals },
  { "matrix_create", matrix_create },
  { "matrix_xx", matrix_xx },
  { "matrix_yx", matrix_yx },
  { "matrix_xy", matrix_xy },
  { "matrix_yy", matrix_yy },
  { "matrix_x0", matrix_x0 },
  { "matrix_y0", matrix_y0 },
  { "matrix_init", matrix_init },
  { "matrix_init_identity", matrix_init_identity },
  { "matrix_init_translate", matrix_init_translate },
  { "matrix_init_scale", matrix_init_scale },
  { "matrix_init_rotate", matrix_init_rotate },
  { "matrix_translate", matrix_translate },
  { "matrix_scale", matrix_scale },
  { "matrix_rotate", matrix_rotate },
  { "matrix_invert", matrix_invert },
  { "matrix_transform_point", matrix_transform_point },
  { "matrix_transform_distance", matrix_transform_distance },
  { "matrix_multiply", matrix_multiply },
  { "region_create", region_create },
  { "region_create_rectangle", region_create_rectangle },
  { "region_create_rectangles", region_create_rectangles },
  { "region_copy", region_copy },
  { "region_get_extents", region_get_extents },
  { "region_get_num_rectangles", region_get_num_rectangles },
  { "region_get_rectangle", region_get_rectangle },
  { "region_is_empty", region_is_empty },
  { "region_contains_point", region_contains_point },
  { "region_contains_rectangle", region_contains_rectangle },
  { "region_equal", region_equal },
  { "region_translate", region_translate },
  { "region_intersect", region_intersect },
  { "region_intersect_rectangle", region_intersect_rectangle },
  { "region_subtract", region_subtract },
  { "region_subtract_rectangle", region_subtract_rectangle },
  { "region_union", region_union },
  { "region_union_rectangle", region_union_rectangle },
  { "region_xor", region_xor },
  { "region_xor_rectangle", region_xor_rectangle }

};

Dart_NativeFunction resolve(const char* name)
{
    const int SIZE = sizeof(FUNCTIONS_MAP) / sizeof(DartFunctionMap);
    for (int i = 0; i < SIZE; i++) {
        if (strcmp(name, FUNCTIONS_MAP[i].name) == 0)
            return FUNCTIONS_MAP[i].fun;
    }
    return NULL;
}

// cairo_t

void context_create(Dart_NativeArguments args)
{
    Dart_Handle obj = arg_get(&args, 0);
    Dart_Handle surfaceObj = arg_get(&args, 1);

    cairo_surface_t* surface = (cairo_surface_t*) bind_get(surfaceObj);

    Context* ctx = Context::create(surface);

    Utils::setupBindingObject<Context>(obj, ctx);

    Dart_SetReturnValue(args, Dart_Null());
}


void save(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->save();

    Dart_SetReturnValue(args, Dart_Null());
}

void restore(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->restore();

    Dart_SetReturnValue(args, Dart_Null());
}

void push_group(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->pushGroup();

    Dart_SetReturnValue(args, Dart_Null());
}

void push_group_with_content(Dart_NativeArguments args)
{
    int content = arg_get_int(&args, 1);

    Context* ctx = Utils::thisFromArg<Context>(args);

    ctx->pushGroupWithContent(static_cast<cairo_content_t>(content));

    Dart_SetReturnValue(args, Dart_Null());
}

void pop_group_to_source(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->popGroupToSource();

    Dart_SetReturnValue(args, Dart_Null());
}

void set_source_rgb(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double r = arg_get_double(&args, 1);
    double g = arg_get_double(&args, 2);
    double b = arg_get_double(&args, 3);

    ctx->setSourceRgb(r, g, b);

    Dart_SetReturnValue(args, Dart_Null());
}

void set_source_rgba(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double r = arg_get_double(&args, 1);
    double g = arg_get_double(&args, 2);
    double b = arg_get_double(&args, 3);
    double a = arg_get_double(&args, 4);

    ctx->setSourceRgba(r, g, b, a);

    Dart_SetReturnValue(args, Dart_Null());
}

void stroke(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->stroke();

    Dart_SetReturnValue(args, Dart_Null());
}

void stroke_preserve(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->strokePreserve();

    Dart_SetReturnValue(args, Dart_Null());
}

void in_stroke(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);

    bool res = ctx->inStroke(x, y);

    Dart_SetReturnValue(args, Dart_NewBoolean(res));
}

void stroke_extents(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x1, y1, x2, y2;

    ctx->strokeExtents(&x1, &y1, &x2, &y2);

    double width = x2 - x1;
    double height = y2 - y1;

    Dart_Handle rect = Utils::newRectangle(x1, y1, width, height);

    Dart_SetReturnValue(args, rect);
}

void paint(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->paint();

    Dart_SetReturnValue(args, Dart_Null());
}


void set_line_cap(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_line_cap_t cap = static_cast<cairo_line_cap_t>(arg_get_int(&args, 1));
    ctx->setLineCap(cap);

    Dart_SetReturnValue(args, Dart_Null());
}

void get_line_cap(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_line_cap_t cap = ctx->getLineCap();
    int c = static_cast<int>(cap);

    Dart_Handle capArgs[1] = { Dart_NewInteger(c) };
    Dart_Handle capObj = Utils::newObject("_LineCap", "", 1, capArgs);
    Dart_SetReturnValue(args, capObj);
}

void set_line_join(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->setLineJoin(static_cast<cairo_line_join_t>(arg_get_int(&args, 1)));
    Dart_SetReturnValue(args, Dart_Null());
}

void get_line_join(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_line_join_t join = ctx->getLineJoin();

    int j = static_cast<int>(join);

    Dart_Handle joinArgs[1] = { Dart_NewInteger(j) };
    Dart_Handle joinObj = Utils::newObject("_LineJoin", "", 1, joinArgs);
    Dart_SetReturnValue(args, joinObj);
}

void set_line_width(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->setLineWidth(arg_get_double(&args, 1));
    Dart_SetReturnValue(args, Dart_Null());
}

void get_line_width(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double width = ctx->getLineWidth();
    Dart_SetReturnValue(args, Dart_NewDouble(width));
}

void set_miter_limit(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->setMiterLimit(arg_get_double(&args, 1));
    Dart_SetReturnValue(args, Dart_Null());
}

void get_miter_limit(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double limit = ctx->getMiterLimit();
    Dart_SetReturnValue(args, Dart_NewDouble(limit));
}

void set_operator(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_operator_t op = static_cast<cairo_operator_t>(arg_get_int(&args, 1));
    ctx->setOperator(op);
    Dart_SetReturnValue(args, Dart_Null());
}

void get_operator(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    int op = static_cast<int>(ctx->getOperator());

    Dart_Handle opArgs[1] = { Dart_NewInteger(op) };
    Dart_Handle opObj = Utils::newObject("_Operator", "", 1, opArgs);
    Dart_SetReturnValue(args, opObj);
}

void set_fill_rule(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_fill_rule_t rule = static_cast<cairo_fill_rule_t>(arg_get_int(&args, 1));
    ctx->setFillRule(rule);
    Dart_SetReturnValue(args, Dart_Null());
}

void get_fill_rule(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    int rule = static_cast<int>(ctx->getFillRule());

    Dart_Handle ruleArgs[1] = { Dart_NewInteger(rule) };
    Dart_Handle ruleObj = Utils::newObject("_FillRule", "", 1, ruleArgs);
    Dart_SetReturnValue(args, ruleObj);
}

void has_current_point(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    bool hasPoint = ctx->hasCurrentPoint();
    Dart_SetReturnValue(args, Dart_NewBoolean(hasPoint));
}

void move_to(Dart_NativeArguments args)
{
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->moveTo(x, y);

    Dart_SetReturnValue(args, Dart_Null());
}

void line_to(Dart_NativeArguments args)
{
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->lineTo(x, y);

    Dart_SetReturnValue(args, Dart_Null());
}

void rectangle(Dart_NativeArguments args)
{
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);
    double w = arg_get_double(&args, 3);
    double h = arg_get_double(&args, 4);
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->rectangle(x, y, w, h);

    Dart_SetReturnValue(args, Dart_Null());
}

void get_current_point(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x;
    double y;
    ctx->getCurrentPoint(&x, &y);

    Dart_Handle point = Utils::newPoint(x, y);
    Dart_SetReturnValue(args, point);
}

void new_path(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->newPath();
    Dart_SetReturnValue(args, Dart_Null());
}

void new_sub_path(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->newSubpath();
    Dart_SetReturnValue(args, Dart_Null());
}

void close_path(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->closePath();
    Dart_SetReturnValue(args, Dart_Null());
}

void arc(Dart_NativeArguments args)
{
    double xc = arg_get_double(&args, 1);
    double yc = arg_get_double(&args, 2);
    double radius = arg_get_double(&args, 3);
    double angle1 = arg_get_double(&args, 4);
    double angle2 = arg_get_double(&args, 5);

    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->arc(xc, yc, radius, angle1, angle2);

    Dart_SetReturnValue(args, Dart_Null());
}

void arc_negative(Dart_NativeArguments args)
{
    double xc = arg_get_double(&args, 1);
    double yc = arg_get_double(&args, 2);
    double radius = arg_get_double(&args, 3);
    double angle1 = arg_get_double(&args, 4);
    double angle2 = arg_get_double(&args, 5);

    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->negativeArc(xc, yc, radius, angle1, angle2);

    Dart_SetReturnValue(args, Dart_Null());
}

void curve_to(Dart_NativeArguments args)
{
    double x1 = arg_get_double(&args, 1);
    double y1 = arg_get_double(&args, 2);
    double x2 = arg_get_double(&args, 3);
    double y2 = arg_get_double(&args, 4);
    double x3 = arg_get_double(&args, 5);
    double y3 = arg_get_double(&args, 6);

    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->curveTo(x1, y1, x2, y2, x3, y3);

    Dart_SetReturnValue(args, Dart_Null());
}

void rel_line_to(Dart_NativeArguments args)
{
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->relLineTo(x, y);

    Dart_SetReturnValue(args, Dart_Null());
}

void rel_move_to(Dart_NativeArguments args)
{
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->relMoveTo(x, y);

    Dart_SetReturnValue(args, Dart_Null());
}

void rel_curve_to(Dart_NativeArguments args)
{
    double x1 = arg_get_double(&args, 1);
    double y1 = arg_get_double(&args, 2);
    double x2 = arg_get_double(&args, 3);
    double y2 = arg_get_double(&args, 4);
    double x3 = arg_get_double(&args, 5);
    double y3 = arg_get_double(&args, 6);

    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->relCurveTo(x1, y1, x2, y2, x3, y3);

    Dart_SetReturnValue(args, Dart_Null());
}

void text_path(Dart_NativeArguments args)
{
    std::string text(arg_get_string(&args, 1));

    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->textPath(text.c_str());

    Dart_SetReturnValue(args, Dart_Null());
}

void path_extents(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x1, y1, x2, y2 = 0.0D;
    ctx->pathExtents(&x1, &y1, &x2, &y2);

    Dart_Handle rect = Utils::newRectangle(x1, y1, x1 + x2, y1 + y2);
    Dart_SetReturnValue(args, rect);
}

void get_antialias(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_antialias_t antialias = ctx->getAntialias();
    int val = static_cast<int>(antialias);

    Dart_Handle antialiasArgs[1] = { Dart_NewInteger(val) };
    Dart_Handle result = Utils::newObject("_Antialias", "", 1, antialiasArgs);

    Dart_SetReturnValue(args, result);
}

void set_antialias(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_antialias_t antialias = static_cast<cairo_antialias_t>(arg_get_int(&args, 1));

    ctx->setAntialias(antialias);
    Dart_SetReturnValue(args, Dart_Null());
}

void get_tolerance(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double tolerance = ctx->getTolerance();
    Dart_SetReturnValue(args, Dart_NewDouble(tolerance));
}

void set_tolerance(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double tolerance = arg_get_double(&args, 1);
    ctx->setTolerance(tolerance);
    Dart_SetReturnValue(args, Dart_Null());
}

void clip(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->clip();
    Dart_SetReturnValue(args, Dart_Null());
}

void clip_preserve(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->clipPreserve();
    Dart_SetReturnValue(args, Dart_Null());
}

void in_clip(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);

    bool result = ctx->inClip(x, y);
    Dart_SetReturnValue(args, Dart_NewBoolean(result));
}

void reset_clip(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->resetClip();
    Dart_SetReturnValue(args, Dart_Null());
}

void clip_extents(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x1, y1, x2, y2;

    ctx->clipExtents(&x1, &y1, &x2, &y2);

    double width = x2 - x1;
    double height = y2 - y1;

    Dart_Handle rect = Utils::newRectangle(x1, y1, width, height);

    Dart_SetReturnValue(args, rect);
}

void fill(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->fill();
    Dart_SetReturnValue(args, Dart_Null());
}

void fill_preserve(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    ctx->fillPreserve();
    Dart_SetReturnValue(args, Dart_Null());
}

void fill_extents(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x1, y1, x2, y2;

    ctx->fillExtents(&x1, &y1, &x2, &y2);

    double width = x2 - x1;
    double height = y2 - y1;

    Dart_Handle rect = Utils::newRectangle(x1, y1, width, height);

    Dart_SetReturnValue(args, rect);
}

void in_fill(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double x = arg_get_double(&args, 1);
    double y = arg_get_double(&args, 2);

    bool result = ctx->inFill(x, y);
    Dart_SetReturnValue(args, Dart_NewBoolean(result));
}


void copy_clip_rectangle_list(Dart_NativeArguments args)
{
    Dart_Handle context = arg_get(&args, 0);
    Context* ctx = Utils::thisFromArg<Context>(args);

    cairo_rectangle_list_t* rectList = ctx->copyClipRectangleList();

    Dart_Handle result = Utils::newRectangleList(context, rectList);
    Utils::setupBindingObject<cairo_rectangle_list_t>(result, rectList, false);

    Dart_SetReturnValue(args, result);
}

void rectangle_list_destroy(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    Dart_Handle rectList = arg_get(&args, 1);

    cairo_rectangle_list_t* list = Utils::bindingObject<cairo_rectangle_list_t>(rectList);
    ctx->destroyRectangleList(list);

    Dart_SetReturnValue(args, Dart_Null());
}

void mask(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    Dart_Handle patternArg = arg_get(&args, 1);
    cairo_pattern_t* pattern = (cairo_pattern_t*)bind_get(patternArg);

    ctx->mask(pattern);

    Dart_SetReturnValue(args, Dart_Null());
}

void mask_surface(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    Dart_Handle surfaceArg = arg_get(&args, 1);
    double x = arg_get_double(&args, 2);
    double y = arg_get_double(&args, 3);
    cairo_surface_t* surface = (cairo_surface_t*) bind_get(surfaceArg);

    ctx->maskSurface(surface, x, y);

    Dart_SetReturnValue(args, Dart_Null());
}

void paint_with_alpha(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    double alpha = arg_get_double(&args, 1);

    ctx->paintWithAlpha(alpha);

    Dart_SetReturnValue(args, Dart_Null());
}

void show_page(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);

    ctx->showPage();

    Dart_SetReturnValue(args, Dart_Null());
}

void copy_page(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);

    ctx->copyPage();

    Dart_SetReturnValue(args, Dart_Null());
}

void set_dash(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    Dart_Handle dashesList = arg_get(&args, 1);
    double offset = arg_get_double(&args, 2);;

    int num = Utils::listLength(dashesList);

    double dashes[num];
    for (int i = 0; i < num; i++)
    {
       dashes[i] = Utils::doubleAt(dashesList, i);
    }

    ctx->setDash(dashes, num, offset);

    Dart_SetReturnValue(args, Dart_Null());
}

void get_dash(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    int count = ctx->getDashCount();
    double dashes[count];
    double offset = 0.0D;

    ctx->getDash(dashes, &offset);


    Dart_Handle dashesHandle = Utils::newList(count);
    for (int i = 0; i < count; i++)
    {
        Dart_ListSetAt(dashesHandle, i, Dart_NewDouble(dashes[i]));
    }

    Dart_Handle offsetHandle = Dart_NewDouble(offset);

    Dart_Handle ctorArgs[2] = { dashesHandle, offsetHandle };
    Dart_Handle dash = Utils::newObject("_Dash", "", 2, ctorArgs);

    Dart_SetReturnValue(args, dash);
}

void get_dash_count(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    int count = ctx->getDashCount();
    Dart_SetReturnValue(args, Dart_NewInteger(count));
}

void pop_group(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_pattern_t* pattern = ctx->popGroup();

    Dart_Handle patternObj = Utils::newPattern(pattern);

    bind_setup(pattern, patternObj, pattern_destroy);
    Dart_SetReturnValue(args, patternObj);
}

void set_source(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    Dart_Handle patternObj = arg_get(&args, 1);
    cairo_pattern_t* pattern = (cairo_pattern_t*)bind_get(patternObj);

    ctx->setSource(pattern);

    Dart_SetReturnValue(args, Dart_Null());
}

void get_source(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);

    cairo_pattern_t* pattern = ctx->getSource();

    if (pattern == nullptr)
    {
        Dart_SetReturnValue(args, Dart_Null());
        return;
    }

    Dart_Handle patternObj = Utils::newPattern(pattern);
    bind_setup(pattern, patternObj, pattern_destroy);

    Dart_SetReturnValue(args, patternObj);
}

void set_source_surface(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    Dart_Handle surfaceObj = arg_get(&args, 1);
    double x = arg_get_double(&args, 2);
    double y = arg_get_double(&args, 3);
    cairo_surface_t* surface = (cairo_surface_t*) bind_get(surfaceObj);

    ctx->setSourceSurface(surface, x, y);

    Dart_SetReturnValue(args, Dart_Null());
}

void get_group_target(Dart_NativeArguments args)
{
    Context* ctx = Utils::thisFromArg<Context>(args);
    cairo_surface_t* surface = ctx->getGroupTarget();
    Dart_Handle res = Utils::newSurface(surface);

    bind_setup(surface, res, surface_destroy);

    Dart_SetReturnValue(args, res);
}


// cairo_format_t

void format_stride_for_width(Dart_NativeArguments args)
{
    cairo_format_t format = (cairo_format_t) arg_get_int(&args, 1);
    int width = arg_get_int(&args, 2);

    int stride = cairo_format_stride_for_width(format, width);

    Dart_SetReturnValue(args, Dart_NewInteger(stride));
}



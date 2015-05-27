#include "dart_api.h"
#include "cairodart.h"
#include "infrastructure/infrastructure.h"
#include "library.h"

using namespace cairodart::infrastructure;
using namespace cairodart::bindings;

static Dart_Handle CAIRODART_LIB;


namespace cairodart
{

namespace infrastructure
{
    Dart_Handle getLibrary()
    {
        return CAIRODART_LIB;
    }
}

}

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* auto_setup_scope);

DART_EXPORT Dart_Handle cairodart_Init(Dart_Handle parent_library)
{
    if (Dart_IsError(parent_library))
        return parent_library;

    Dart_Handle result_code = Dart_SetNativeResolver(parent_library, ResolveName, NULL);
    if (Dart_IsError(result_code))
        return result_code;

    CAIRODART_LIB = Dart_NewPersistentHandle(parent_library);
    library_set(CAIRODART_LIB);
    return Dart_Null();
}

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* auto_setup_scope)
{
    UNUSED(argc)
    UNUSED(auto_setup_scope)

    if (!Utils::isString(name))
        return NULL;
    Dart_NativeFunction result = NULL;


    std::string funcName = Utils::toString(name);

    result = CairoDart::resolve(funcName);
    return result;
}

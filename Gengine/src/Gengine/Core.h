#pragma Eonce

#ifdef GE_PLATFORM_MACOS
#    define GAPI __attribute__( ( visibility( "default" ) ) )
#else
#    define GAPI
#endif

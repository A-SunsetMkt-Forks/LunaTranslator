
include(FetchContent)

#https://github.com/ikegami-yukino/mecab clone太几把慢了
FetchContent_Declare(mecab
    GIT_REPOSITORY https://github.com/HIllya51/mecab
    GIT_TAG master
    GIT_SHALLOW TRUE
)
FetchContent_Populate(mecab)

set(mecabsrc "${mecab_SOURCE_DIR}/mecab/src")

if(NOT EXISTS "${mecabsrc}/writeonceflag")

    file(READ "${mecabsrc}/dictionary.cpp" dictionary)
    set(std_binary_function [=[

  template <class Argv1, class Argv2, class Result>
  struct std_binary_function_FUCK
  {
    typedef Argv1 first_argument_type;
    typedef Argv2 second_argument_type;
    typedef Result result_type;
  };
]=])
    string(REPLACE "std::binary_function" "std_binary_function_FUCK" dictionary "${dictionary}")
    file(WRITE "${mecabsrc}/dictionary.cpp" "${std_binary_function}${dictionary}")

    file(READ "${mecabsrc}/mecab.h" mecabh)
    string(REPLACE "__declspec(dllexport)" "" mecabh "${mecabh}")
    string(REPLACE "__declspec(dllimport)" "" mecabh "${mecabh}")
    file(WRITE "${mecabsrc}/mecab.h" "${mecabh}")

    file(WRITE "${mecabsrc}/writeonceflag" "")
endif()

file(GLOB SOURCES "${mecabsrc}/*.cpp")
list(FILTER SOURCES EXCLUDE REGEX ".*/mecab[a-z\\-]*\\.cpp")

add_library(libmecab ${SOURCES})

target_include_directories(libmecab INTERFACE "${mecabsrc}")
if(MSVC)
target_compile_options(libmecab PRIVATE /EHsc
                                        /std:c++14
                                        /GL         
                                        /GA       
                                        /Ob2        
                                        /W3         
                                        /nologo    
                                        /Zi        
                                        /wd4800    
                                        /wd4305
                                        /wd4267
                                        /wd4244)
else()
target_compile_options(libmecab PRIVATE -std=c++14)
endif()
target_compile_definitions(
    libmecab PRIVATE
    -D_CRT_SECURE_NO_DEPRECATE
    -DMECAB_USE_THREAD
    -DDLL_EXPORT
    -DHAVE_GETENV
    -DHAVE_WINDOWS_H
    -DDIC_VERSION=102
    -DVERSION="0.996"
    -DPACKAGE="mecab"
    -DUNICODE
    -D_UNICODE
    -DMECAB_DEFAULT_RC="c:\\\\Program Files\\\\mecab\\\\etc\\\\mecabrc"
)
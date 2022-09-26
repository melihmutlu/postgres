ecpglib_sources = files(
  'connect.c',
  'data.c',
  'descriptor.c',
  'error.c',
  'execute.c',
  'memory.c',
  'misc.c',
  'prepare.c',
  'sqlda.c',
  'typename.c',
)
ecpglib_so_sources = [] # only for shared lib, in addition to above

ecpglib_inc = ['.', ecpg_inc, postgres_inc]
ecpglib_c_args = ['-DSO_MAJOR_VERSION=6']
export_file = custom_target('libecpg.exports', kwargs: gen_export_kwargs)

if host_system == 'windows'
  ecpglib_so_sources += rc_lib_gen.process(win32ver_rc, extra_args: [
    '--NAME', 'libecpg',
    '--FILEDESC', 'ECPG - embedded SQL in C',])
endif

# not using both_libraries(), as the resource file should only be in the
# shared library
ecpglib_st = static_library('libecpg',
  ecpglib_sources,
  include_directories: ecpglib_inc,
  c_args: ecpglib_c_args,
  pic: true,
  dependencies: [frontend_code, libpq, thread_dep],
  link_with: [ecpg_pgtypes_so],
  kwargs: default_lib_args,
)
ecpg_targets += ecpglib_st

ecpglib_so = shared_library('libecpg',
  ecpglib_so_sources,
  include_directories: ecpglib_inc,
  c_args: ecpglib_c_args,
  dependencies: [frontend_code, libpq, thread_dep],
  link_whole: ecpglib_st,
  link_with: [ecpg_pgtypes_so],
  soversion: host_system != 'windows' ? '6' : '',
  darwin_versions: ['6', '6.' + pg_version_major.to_string()],
  version: '6.' + pg_version_major.to_string(),
  link_args: export_fmt.format(export_file.full_path()),
  link_depends: export_file,
  kwargs: default_lib_args,
)
ecpg_targets += ecpglib_so

pkgconfig.generate(
  ecpglib_so,
  requires_private: 'libpgtypes',
  description: 'PostgreSQL libecpg library',
  url: pg_url,
)

subdir('po', if_found: libintl)

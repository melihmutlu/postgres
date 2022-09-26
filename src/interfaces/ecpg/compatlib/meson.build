ecpg_compat_sources = files(
  'informix.c',
)
ecpg_compat_so_sources = [] # only for shared lib, in addition to above

ecpg_compat_inc = ['.', ecpg_inc, postgres_inc, libpq_inc]
ecpg_compat_c_args = ['-DSO_MAJOR_VERSION=3']
export_file = custom_target('libecpg_compat.exports', kwargs: gen_export_kwargs)

# not using both_libraries(), as the resource file should only be in the
# shared library
ecpg_compat_st = static_library('libecpg_compat',
  ecpg_compat_sources,
  include_directories: ecpg_compat_inc,
  c_args: ecpg_compat_c_args,
  pic: true,
  dependencies: [frontend_code, thread_dep],
  kwargs: default_lib_args,
)
ecpg_targets += ecpg_compat_st

ecpg_compat_so = shared_library('libecpg_compat',
  ecpg_compat_so_sources,
  include_directories: ecpg_compat_inc,
  c_args: ecpg_compat_c_args,
  dependencies: [frontend_code, thread_dep],
  link_whole: ecpg_compat_st,
  link_with: [ecpglib_so, ecpg_pgtypes_so],
  soversion: host_system != 'windows' ? '3' : '',
  darwin_versions: ['3', '3.' + pg_version_major.to_string()],
  version: '3.' + pg_version_major.to_string(),
  link_args: export_fmt.format(export_file.full_path()),
  link_depends: export_file,
  kwargs: default_lib_args,
)
ecpg_targets += ecpg_compat_so

pkgconfig.generate(
  ecpg_compat_so,
  requires_private: 'libpgtypes',
  description: 'PostgreSQL libecpg_compat library',
  url: pg_url,
)

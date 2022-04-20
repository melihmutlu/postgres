executable('uri-regress',
  files('uri-regress.c'),
  dependencies: [frontend_code, libpq],
  kwargs: default_bin_args + {
    'install': false,
  }
)

executable('testclient',
  files('testclient.c'),
  dependencies: [frontend_code, libpq],
  kwargs: default_bin_args + {
    'install': false,
  }
)

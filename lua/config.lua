config_track_actions = false

WriteGuards = {
  WriteGuard = true,
  WriteGuardBag = true,
  WriteGuardObj = true,
}

ReadGuards = {
  ReadGuard = true,
  ReadGuardBag = true,
  ReadGuardObj = true,
}

preprocessor_defines = {
  HAVE_NATIVE_TLS = 1,
  CONFIG_H = 1,
}

preprocessor_options = {
  "-I.",
  "-Iarch",
}

local R, W = "R", "W"
local VA = -1

Externals = {
  memcpy = { W, R, nil },
  memset = { W, nil, nil },
  read= { nil, R, nil, nil },
  write = { nil, W, nil, nil },
  bcopy = { R, W, nil },
  printf = { R, VA = R },
  sprintf = { R, R, VA = R },
  fprintf = { R, R, VA = R },
  fputs = { R, R },
  fgets = { R, W },
}
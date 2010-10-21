#!/bin/sh
export LUA_ROOT=`pwd`
case `uname -s` in
  Darwin)
    export PLATFORM=macosx
    ;;
  Linux)
    export PLATFORM=linux
    ;;
  *)
    export PLATFORM=posix
    ;;
esac
cd $LUA_ROOT/ext/lua-5.1.4
make INSTALL_TOP=$LUA_ROOT $PLATFORM install
cd $LUA_ROOT/ext/LuaJIT-2.0.0-beta3
make PREFIX=$LUA_ROOT install
cd $LUA_ROOT/bin
ln -s luajit-2.0.0-beta3 luajit2
export PATH=$LUA_ROOT/bin:$PATH
cd $LUA_ROOT/ext/luarocks-2.0.2
./configure
make install
cd $LUA_ROOT/ext/lpeg-list
make && cp listlpeg.so $LUA_ROOT/lib/lua/5.1
cd $LUA_ROOT
LUA_PATH=`bin/lua -e 'print(package.path)'`
cat >bin/ward <<EOF
#!/bin/sh
export LUA_PATH='$LUA_ROOT/lua/?.lua;$LUA_PATH'
"$LUA_ROOT/bin/lua" "$LUA_ROOT/lua/ward.lua" "\$@"
EOF
chmod 755 bin/ward
cat >bin/cward <<EOF
#!/bin/sh
export LUA_PATH='$LUA_ROOT/lua/?.lua;$LUA_PATH'
"$LUA_ROOT/bin/luajit2" "$LUA_ROOT/lua/ward.lua" "\$@"
EOF
chmod 755 bin/cward
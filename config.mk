# st version
VERSION = 0.9.3

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man
ICONPREFIX = $(PREFIX)/share/pixmaps
ICONNAME = st.png

PKG_CONFIG = pkg-config

# alpha
XRENDER = xrender

# ligatures (you need to comment out the four lines below if ligatures are
# permanently disabled in config.h)
LIGATURES_C = hb.c
LIGATURES_H = hb.h
LIGATURES_INC = `$(PKG_CONFIG) --cflags harfbuzz`
LIGATURES_LIBS = `$(PKG_CONFIG) --libs harfbuzz`

# sixel
SIXEL_C = sixel.c sixel_hls.c

# includes and libs
INCS = `$(PKG_CONFIG) --cflags x11 xft $(XRENDER)` \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2` \
       `$(PKG_CONFIG) --cflags imlib2` \
       `$(PKG_CONFIG) --cflags gdlib` \
       $(LIGATURES_INC)
LIBS = -lm -lutil $(LIBRT) ${XCURSOR} ${PROCSTAT}\
       `$(PKG_CONFIG) --libs x11 xft $(XRENDER)` \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2` \
       `$(PKG_CONFIG) --libs imlib2` \
       `$(PKG_CONFIG) --libs gdlib` \
       $(LIGATURES_LIBS)

# macOS has no librt; clock_gettime lives in libSystem there
LIBRT = `uname -s | grep -q Darwin || echo -lrt`

# flags
# _XOPEN_SOURCE on its own hides SIGWINCH and struct winsize on macOS
DARWINFLAGS = `uname -s | grep -q Darwin && echo -D_DARWIN_C_SOURCE`
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -DICON=\"$(ICONPREFIX)/$(ICONNAME)\" -D_XOPEN_SOURCE=600 $(DARWINFLAGS)
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

# FreeBSD:
#CPPFLAGS = -D_FREEBSD_SOURCE -D__BSD_VISIBLE
#PROCSTAT = -lprocstat

# OpenBSD:
#CPPFLAGS = -D_BSD_SOURCE
#LIBRT =
#MANPREFIX = ${PREFIX}/man

# compiler and linker
# CC = c99

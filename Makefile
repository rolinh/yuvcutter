INSTALL=install
MKDIR=mkdir
RM=rm
RONN=ronn
TEST=test

CC ?= gcc
CFLAGS ?= -O2
LDFLAGS +=
CFDEBUG = -O0 -g3 -pedantic -Wall -Wextra -Wconversion -Wstrict-prototypes \
		  -Wcast-qual -Wcast-align -Wshadow -Wredundant-decls -Wundef \
		  -Wfloat-equal -Wmissing-include-dirs -Wswitch-default -Wswitch-enum \
		  -Wpointer-arith -Wbad-function-cast -Wnested-externs \
		  -Wold-style-definition -Wsign-conversion -Wlogical-op \
		  -Wno-long-long -pipe -Wunreachable-code

EXEC = yuvcutter
VERSION = 0.2.0

MAN=man
MAN1=man1
SRC=src

SRCS= ${SRC}/yuvcutter.c

OBJS= ${SRCS:.c=.o}

.PATH: ${SRC}

PREFIX?=/usr/local
BINDIR=${PREFIX}/bin
MANDIR=${PREFIX}/man

all: ${EXEC}

.c.o:
	${CC} ${CFLAGS} -o $@ -c $<

${EXEC}: ${OBJS}
	${CC} -o ${EXEC} ${OBJS} ${LDFLAGS}

doc:
	${RONN} -r --manual "USER COMMANDS" --pipe --organization "${EXEC} ${VERSION}" ${MAN}/${EXEC}.1.ronn > ${MAN}/${MAN1}/${EXEC}.1

install-main: ${EXEC}
	${TEST} -d ${DESTDIR}${BINDIR} || ${MKDIR} -p ${DESTDIR}${BINDIR}
	${INSTALL} -m755 ${EXEC} ${DESTDIR}${BINDIR}/${EXEC}

install-data: ${MAN}/${MAN1}/${EXEC}.1
	${TEST} -d ${DESTDIR}${MANDIR}/${MAN1} || ${MKDIR} -p ${DESTDIR}${MANDIR}/${MAN1}
	${INSTALL} -m644 ${MAN}/${MAN1}/${EXEC}.1 ${DESTDIR}${MANDIR}/${MAN1}/${EXEC}.1

install: all install-main install-data

debug: ${EXEC}
debug: ${CC} += ${CFDEBUG}

clean:
	${RM} -rf ${SRC}/*.o

mrproper: clean
	${RM} ${EXEC}

.PHONY: all clean doc mrproper install install-main install-data

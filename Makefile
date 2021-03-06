
CC=gcc
PROG_NAME=main
INCS=base_const.h callback.h drawfb.h file_op.h main.h \
base.h content_en.h drawui.h language.h	base_config.h \
spi_d.h draw_dialog.h

SRCS=callback.c content_en.c drawfb.c drawui.c file_op.c main.c base_config.c spi_d.c draw_dialog.c content_ch.c

# 从xx.c 文件得到 xx.o 文件
OBJS=${SRCS:.c=.o}

#编译GTK程序时要用到的库
LIBS=webkit-1.0 libxml-2.0 libfakekey
#---- 用户修改区域 结束

# -O2
CFLAGS=`pkg-config --cflags ${LIBS}` -O0 -DX86 -Wall -g
LDFLAGS=`pkg-config --libs ${LIBS}` -Wall -g

all: ${PROG_NAME}

${PROG_NAME}:${OBJS} focallaw.o
	${CC} -o ${PROG_NAME} ${OBJS} ${LDFLAGS} focallaw.o
#注意：上边”${CC}" 的前边有一个TAB键，而不是空格

#如果有头文件进行修改，则自动编译源文件
${OBJS}:${INCS}

.c.o:
	${CC} -c $<  ${CFLAGS}

.PHONY:clean
clean:
	rm -f ${PROG_NAME} ${OBJS}

rebuild: clean all

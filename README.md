# SYNOPSIS

**yuvcutter** cuts the first "N" frames from raw YUV video files. "N" is equal
to "1" by default but you can easily change it using `-N` option.
YUV supported format are 4:2:0, 4:2:2 and 4:4:4.
Note that as this YUV files are raw files with no information on content, you
need to specify the video width and height in order for **yuvcutter** to behave
as expected. By default, it assumes the input video is "1920x1080".

Why would I need to cut the first frames from a YUV file you might ask?
Here is a typical use case: you have an H264 encoded video file and you want to
compute the PSNR by comparing it to the original YUV video that was used as a
record source. Therefore, you use the H264/AVC JM reference software to decode
the video and compare the resulting YUV file with the original file. However, if
you want your computed PSNR to be correct, you need the two videos to start at
exactly the same frame each. Here comes **yuvcutter** as it allows you to cut
the first "N" frames of your reference video file so your both YUV files start
with the same video frame.

# BUILD

**yuvcutter** has not dependy apart from the standard C library.
To generate `yuvcutter` executable, just type the following from the root's
directory:

    make

To generate the manpage, type the following:

    make doc

Please, note that you normally do not have to generate the manual page since I
keep an updated copy in man/man1 directory. However, if you want to regenerate
the manpage, you will need to have the `ronn` tool installed on your machine
(`ronn` can be installed as a gem by typing `gem install ronn`).

If you want to install **yuvcutter** on your system, simply type the following:

    make install

By default, it will install in "/usr/local" folder but you can change the
destination by specifying the "DESTDIR" variable.

<!-- vim: set filetype=markdown textwidth=80 -->

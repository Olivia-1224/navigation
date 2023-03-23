#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/olivia/nav_ws/src/navigation/src/base_local_planner"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/olivia/nav_ws/src/navigation/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/olivia/nav_ws/src/navigation/install/lib/python2.7/dist-packages:/home/olivia/nav_ws/src/navigation/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/olivia/nav_ws/src/navigation/build" \
    "/usr/bin/python2" \
    "/home/olivia/nav_ws/src/navigation/src/base_local_planner/setup.py" \
     \
    build --build-base "/home/olivia/nav_ws/src/navigation/build/base_local_planner" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/olivia/nav_ws/src/navigation/install" --install-scripts="/home/olivia/nav_ws/src/navigation/install/bin"

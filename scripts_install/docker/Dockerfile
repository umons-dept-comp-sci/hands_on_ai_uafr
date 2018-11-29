FROM osrf/ros:lunar-desktop-full

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    sudo net-tools apt-utils wget python-catkin-tools dialog less vim \
    ros-lunar-desktop-full ros-lunar-cartographer ros-lunar-cartographer-ros \
    ros-lunar-cartographer-rviz ros-lunar-joy ros-lunar-teleop-twist-keyboard \
    ros-lunar-laser-proc ros-lunar-rgbd-launch ros-lunar-rosserial-arduino \
    ros-lunar-rosserial-python ros-lunar-rosserial-server \
    ros-lunar-rosserial-client ros-lunar-rosserial-msgs ros-lunar-amcl \
    ros-lunar-map-server ros-lunar-move-base ros-lunar-urdf ros-lunar-xacro \
    ros-lunar-compressed-image-transport ros-lunar-rqt-image-view \
    ros-lunar-gmapping ros-lunar-navigation ros-lunar-interactive-markers \
    ros-lunar-catkin ros-lunar-catkin-virtualenv ros-lunar-rqt-* \
    ros-lunar-moveit ros-lunar-moveit-runtime ros-lunar-moveit-sim-controller \
    ros-lunar-moveit-sim-controller ros-lunar-moveit-python \
    ros-lunar-moveit-resources \
    python-wstool ninja-build && \
    rm -rf /var/lib/apt/lists/*

# This will issue a warning that we can ignore.
RUN rosdep update

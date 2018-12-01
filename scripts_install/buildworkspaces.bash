orig_dir="$(pwd)"
source /opt/ros/lunar/setup.bash
echo 'source /opt/ros/lunar/setup.bash' >> rosentrypoint.bash

# Create a workspace to hold the cartographer.
# We do this because we'll have to build it isolated and we don't want to build
# the whole environment that way.
mkdir -p cartographer_ws
cd cartographer_ws
wstool init src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall

# Build protobuf 3 and install it locally in the workspace.
git clone https://github.com/google/protobuf.git
cd protobuf
git checkout tags/v3.4.1
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  -DCMAKE_INSTALL_PREFIX=../../install_isolated \
  ../cmake
ninja
ninja install
cd ../../

# Go back to building cartographer
#rosdep update
#rosdep install --from-paths src --ignore-src --rosdistro=lunar -y
catkin_make_isolated --install --use-ninja

cd "$orig_dir"
source cartographer_ws/install_isolated/setup.bash
echo "source \"$orig_dir/cartographer_ws/install_isolated/setup.bash\"" >> rosentrypoint.bash

# Create a workspace to hold all the other stuff
mkdir catkin_ws
cd catkin_ws
wstool init src
wstool set -y turtlebot3_msgs \
  --git https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git -t src
wstool set -y turtlebot3 \
  --git https://github.com/ROBOTIS-GIT/turtlebot3.git -t src
wstool set -y turtlebot3_simulation \
  --git https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git -t src
wstool set -y uafr \
  --git https://github.com/umons-dept-comp-sci/hands_on_ai_uafr.git -t src
wstool update -t src
# FIXME: how to recursively clone a git repo with wstool ?
cd src
git clone --recursive https://github.com/leggedrobotics/darknet_ros.git darknet_ros
cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release

cd "$orig_dir"
echo "source \"$orig_dir/catkin_ws/devel/setup.bash\"" >> rosentrypoint.bash

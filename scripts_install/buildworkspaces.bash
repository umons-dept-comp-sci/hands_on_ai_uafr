orig_dir="$(pwd)"
source /opt/ros/lunar/setup.bash
echo 'source /opt/ros/lunar/setup.bash' >> rosentrypoint.bash
mkdir -p cartographer_ws
cd cartographer_ws
wstool init src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall

rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=lunar -y

catkin_make_isolated --install --use-ninja

cd "$orig_dir"
source cartographer_ws/install_isolated/setup.bash
echo "source \"$orig_dir/cartographer_ws/install_isolated/setup.bash\"" >> rosentrypoint.bash

mkdir catkin_ws
cd catkin_ws
wstool init src
wstool set turtlebot3_msgs \
  --git https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git -t src
wstool set turtlebot3 \
  --git https://github.com/ROBOTIS-GIT/turtlebot3.git -t src
wstool set turtlebot3_simulation \
  --git https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git -t src
wstool set uafr \
  --git https://github.com/umons-dept-comp-sci/hands_on_ai_uafr.git -t src
wstool update -t src
# How to recursively clone a git repo with wstool ?
cd src
git clone --recursive https://github.com/leggedrobotics/darknet_ros.git darknet_ros
cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release

cd "$orig_dir"
echo "source \"$orig_dir/catkin_ws/devel/setup.bash\"" >> rosentrypoint.bash

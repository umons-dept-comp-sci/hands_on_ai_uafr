-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

NUM_SUBDIVISIONS = 1
NUM_RANGE_DATA = 1

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame ="map",
  tracking_frame = "imu_link",
  published_frame = "odom",
  odom_frame = "odom_gc",
  provide_odom_frame = true,
  publish_frame_projected_to_2d = true,
  use_odometry = true,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 1,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = NUM_SUBDIVISIONS,
  num_point_clouds = 0,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true
MAP_BUILDER.num_background_threads = 2

TRAJECTORY_BUILDER_2D.num_accumulated_range_data = NUM_SUBDIVISIONS
TRAJECTORY_BUILDER_2D.min_range = 0.12
TRAJECTORY_BUILDER_2D.max_range = 16
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 15
TRAJECTORY_BUILDER_2D.use_imu_data = true
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(0.1)
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 3.
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 1e-2
TRAJECTORY_BUILDER_2D.submaps.num_range_data = NUM_RANGE_DATA

POSE_GRAPH.constraint_builder.min_score = 0.8
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.8
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 3.
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(0.1)
POSE_GRAPH.constraint_builder.max_constraint_distance = 1.

return options

#!/bin/bash

echo -n \
'<launch>
  <arg name="world_name"                    default="Free_Name"/>
  <arg name="verbose"                       default="true"/>
  <arg name="gui"                           default="true"/>
  <arg name="x_pose"                        default="0.0"/>
  <arg name="y_pose"                        default="0.0"/>
  <arg name="rviz"                          default="false"/>
  <arg name="use_joint_state_publisher"     default="false"/>

  <include file="$(find-pkg-share gazebo_ros)/launch/gzserver.launch.py">
    <arg name="world" value="$(find-pkg-share raspicat_map2gazebo)/config/world/$(var world_name).world"/>
  </include>

  <group if="$(var gui)">
    <include file="$(find-pkg-share gazebo_ros)/launch/gzclient.launch.py"/>
  </group>

  <include file="$(find-pkg-share raspicat_bringup)/launch/robot_state_publisher.launch.py">
    <arg name="use_joint_state_publisher" value="$(var use_joint_state_publisher)"/>
  </include>

  <include file="$(find-pkg-share raspicat_gazebo)/launch/spawn_raspicat.launch.py">
    <arg name="x_pose" value="$(var x_pose)"/>
    <arg name="y_pose" value="$(var y_pose)"/>
  </include>

  <include file="$(find-pkg-share raspicat_gazebo)/launch/raspicat_simulation.launch.py">
    <arg name="rviz" value="$(var rviz)"/>
  </include>
</launch>' | sed -e 's/Free_Name/'$1'/g' > $(ros2 pkg prefix --share raspicat_map2gazebo | sed 's|/install/.*/share|/src|')/launch/raspicat_$1_world.launch

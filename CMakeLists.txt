cmake_minimum_required(VERSION 3.8)
project(raspicat_map2gazebo)

find_package(ament_cmake_auto REQUIRED)

install(PROGRAMS
  scripts/create_launch_xml.sh
  scripts/map2gazebo_docker.sh
  scripts/output_check.sh
  DESTINATION lib/${PROJECT_NAME}
)

ament_auto_package(
  INSTALL_TO_SHARE
  config
  launch
  scripts
)

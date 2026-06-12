set ROS_DOMAIN_ID 42

if test -f /opt/ros/humble/setup.bash
    bass source /opt/ros/humble/setup.bash
    register-python-argcomplete --shell fish ros2 | source
end

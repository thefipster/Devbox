#!/usr/bin/env bash

# increase virtual memory for elasticsearch to be able to start
sudo sysctl -w vm.max_map_count=262144
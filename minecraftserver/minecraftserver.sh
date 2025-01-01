#!/bin/bash
#git -C /home/d3f1l3/osteboys-docker-mcserver pull origin main
git -C /home/d3f1l3/osteboys-docker-mcserver reset --hard
git -C /home/d3f1l3/osteboys-docker-mcserver pull origin main

docker compose up -d

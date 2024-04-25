#!/bin/bash
git -C /home/josterhaus/osteboys-docker-mcserver pull origin main

docker compose up -d

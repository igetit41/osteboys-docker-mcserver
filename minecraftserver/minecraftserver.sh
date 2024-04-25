#!/bin/bash
git -C ~/osteboys-docker-mcserver pull origin main

docker compose up -d

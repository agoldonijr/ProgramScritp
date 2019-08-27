#!/bin/bash
date
rsync -avz --delete-excluded /home/goldoni/ /opt/lga_home/ 
date

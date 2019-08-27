# Copyright (C) 2019 Alcides Goldoni Junior <agoldonijr@gmail.com>
# Copyright (C) 2019 Alcides Goldoni Junior <goldoni@ggaunicamp.com>

#!/bin/bash
date
rsync -avz --delete-excluded /home/goldoni/ /opt/lga_home/ 
date

# jupyter-server
* Use docker-compose to run a jupyter docker image with directory mount and GPU passthrough.
* Comes pre-installed with git, ipywidgets, jupyter\_http\_over\_ws, nbextension 
* Whatever you pass as `DATA_MOUNT_DIR` will be mounted in the jupyter server as /mnt/ai

## start server by: 
```
DATA_MOUNT_DIR=~/ai docker-compose -f docker-compose.yml up
```

# Fitting tutorial data and docker images together via correct directoring

- When downloading a new docker image and opening it in the docker container, the image may  be 	set up within a default directory not fitting to the previous directory used for prior 	images

- It also may be, that this default directory isn't changeable

- Therefore the data coming with the image download lies within this directory and data of other 	images may not be "seen", because of different default locations of the images

- Remember: docker does not see your physical directory tree on your computer, you have to 	mount! For this you must use the default directory coming with the image

- it´s not enough just fitting the data together in one location via “ls, pwd, cd, mv-orders”, the 	directory of the image itself has to fit to the mounted one


#### sudo docker run -it --rm -v ~/Python_tutorials/:/opt/tutorial -p 8888:8888 satra/ibro-workshop-2017:latest

- opens docker image in bash, while the docker directory is mounted to the physical directory where the data is located 

#### neuro@56bacda17e4d:~$ ls
#### nilearn_data
#### neuro@56bacda17e4d:~$ pwd
#### /home/neuro

- look for image-directory (pwd) and containing data/notebooks (ls)
- notice, that /home/neuro doesn´t fit to the mounted opt/tutorial-directory of previously used images

#### neuro@56bacda17e4d:~$ cd /opt/tutorial

- change image directory to opt/tutorial (or change mounted directory to /home/neuro)

#### sudo docker run -it --rm -v ~/Python_tutorials/:/opt/tutorial -p 8888:8888 satra/ibro-workshop-2017:latest jupyter notebook –ip=* 

- open jupyter notebook in docker without ip- recommendation 

#### jupyter notebook --ip=* --port=8888 

- you need to tell jupyter the Keyport of your docker image!

#### sudo docker run -it --rm -v ~/Python_tutorials/:/opt/tutorial -p 8888:8888 satra/ibro-workshop-2017:latest jupyter notebook --ip=* --port=8888 

- other image, allow all IPs and tell jupyter the port



### The image for the nipype-tutorials:

#### sudo docker run -it --rm -v ~/Python_tutorials/:/home/neuro/nipype_tutorial -p 8888:8888 djarecka/nipype_tutorial:latest jupyter notebook

- here the problem occured, that the image-default-directory /home/neuro/nipype_tutorial was not changeable and therefore obligatory for mounting
- tip: you can define the entrypoint (bash or notebook): sudo docker run -it --entrypoint /bin/bash --rm -v ....
